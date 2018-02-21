Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226VIsmVYPUdpZQjWo9LdqohXwUMkvwmZcIPvusFYv3CUZ0w5odjQVVdrY+N8AK4QCpfyjKE
ARC-Seal: i=1; a=rsa-sha256; t=1519217950; cv=none;
        d=google.com; s=arc-20160816;
        b=Z8jiLyhJFIzYRnjVCuCBI8t6CkLCL1bIfv9fItmoDNfPBIDdAaRhhuctOwSl0JyrQ8
         Mcj/8Czuzkr3kwJWaUJe0GQGgc26hBH++FcEF7r5qrDpp9fw7NCxPbH+5XZZ4eneS8HL
         tKlNll9oDlKXKHstdVlM8HVdeNQYC99fbjsBzOvVKRLGWdslLW6Zml0Hb3cGIzIXDVpt
         WLDChiZqtiv1NpW312RJAe0ZeJKUzpJSVaRpPG92A9/dm3p/k7I2iNKQ5zcBD6U9O+x3
         SKS0B1r81kuVW3jWJucWIMVeNpNwC05x/r8Kuyt1m5qaOfACZ7rxT/rU3v6Sa6GYc/Gv
         vnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jz+lVxhv7KEFYbQrzwXFEDgVopoxvJT2tg3rpZlLswg=;
        b=ASbM5UojSpCuoxiFkAV9pg3lwyoCQDDn1AKtFlMrAaLH9uNldG/G6TxzVfJIKSd6Lu
         1DEes/zYrPW4pl1KWXRk+NXW1DZXDCIdb7/HlGXrz366yPAahgBJoE3Q8675nlmgS1ce
         G2gG/lZnXpXjCiNy2nxGke73Lrc5rEceaXpSyvGXA06snj4VlQPR/SjetkXQ4AYpqhSx
         LLJv9mO1zXC9Q73Lu0AYAkCGU3AeWUuDCIWWgtdEahJvjouFFjKkdWzylyde7DSZzK+2
         yjQbpIUwqp3S6H1xiQKzCJ0ZP8hsFR+2oAG5PMGgPbemWuTGPKlIXNDF246BCx+LHCWk
         PydQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bodong Wang <bodong@mellanox.com>,
	Parav Pandit <parav@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 007/167] IB/core: Fix ib_wc structure size to remain in 64 bytes boundary
Date: Wed, 21 Feb 2018 13:46:58 +0100
Message-Id: <20180221124525.029149938@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015481822044558?=
X-GMAIL-MSGID: =?utf-8?q?1593015481822044558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bodong Wang <bodong@mellanox.com>

commit cd2a6e7d384b043d5d029e39663061cebc949385 upstream.

The change of slid from u16 to u32 results in sizeof(struct ib_wc)
cross 64B boundary, which causes more cache misses. This patch
rearranges the fields and remain the size to 64B.

Pahole output before this change:

struct ib_wc {
        union {
                u64                wr_id;                /*           8 */
                struct ib_cqe *    wr_cqe;               /*           8 */
        };                                               /*     0     8 */
        enum ib_wc_status          status;               /*     8     4 */
        enum ib_wc_opcode          opcode;               /*    12     4 */
        u32                        vendor_err;           /*    16     4 */
        u32                        byte_len;             /*    20     4 */
        struct ib_qp *             qp;                   /*    24     8 */
        union {
                __be32             imm_data;             /*           4 */
                u32                invalidate_rkey;      /*           4 */
        } ex;                                            /*    32     4 */
        u32                        src_qp;               /*    36     4 */
        int                        wc_flags;             /*    40     4 */
        u16                        pkey_index;           /*    44     2 */

        /* XXX 2 bytes hole, try to pack */

        u32                        slid;                 /*    48     4 */
        u8                         sl;                   /*    52     1 */
        u8                         dlid_path_bits;       /*    53     1 */
        u8                         port_num;             /*    54     1 */
        u8                         smac[6];              /*    55     6 */

        /* XXX 1 byte hole, try to pack */

        u16                        vlan_id;              /*    62     2 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u8                         network_hdr_type;     /*    64     1 */

        /* size: 72, cachelines: 2, members: 17 */
        /* sum members: 62, holes: 2, sum holes: 3 */
        /* padding: 7 */
        /* last cacheline: 8 bytes */
};

Pahole output after this change:

struct ib_wc {
        union {
                u64                wr_id;                /*           8 */
                struct ib_cqe *    wr_cqe;               /*           8 */
        };                                               /*     0     8 */
        enum ib_wc_status          status;               /*     8     4 */
        enum ib_wc_opcode          opcode;               /*    12     4 */
        u32                        vendor_err;           /*    16     4 */
        u32                        byte_len;             /*    20     4 */
        struct ib_qp *             qp;                   /*    24     8 */
        union {
                __be32             imm_data;             /*           4 */
                u32                invalidate_rkey;      /*           4 */
        } ex;                                            /*    32     4 */
        u32                        src_qp;               /*    36     4 */
        u32                        slid;                 /*    40     4 */
        int                        wc_flags;             /*    44     4 */
        u16                        pkey_index;           /*    48     2 */
        u8                         sl;                   /*    50     1 */
        u8                         dlid_path_bits;       /*    51     1 */
        u8                         port_num;             /*    52     1 */
        u8                         smac[6];              /*    53     6 */

        /* XXX 1 byte hole, try to pack */

        u16                        vlan_id;              /*    60     2 */
        u8                         network_hdr_type;     /*    62     1 */

        /* size: 64, cachelines: 1, members: 17 */
        /* sum members: 62, holes: 1, sum holes: 1 */
        /* padding: 1 */
};

Fixes: 7db20ecd1d97 ("IB/core: Change wc.slid from 16 to 32 bits")
Signed-off-by: Bodong Wang <bodong@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/rdma/ib_verbs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -971,9 +971,9 @@ struct ib_wc {
 		u32		invalidate_rkey;
 	} ex;
 	u32			src_qp;
+	u32			slid;
 	int			wc_flags;
 	u16			pkey_index;
-	u32			slid;
 	u8			sl;
 	u8			dlid_path_bits;
 	u8			port_num;	/* valid only for DR SMPs on switches */
