Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225gOZMGYDWkPePzC4NK7MoQoL4hqgf5u+UxTYPHmCH+llN6DwFFQhMOH+XDTJTX1RSJ5eab
ARC-Seal: i=1; a=rsa-sha256; t=1519218388; cv=none;
        d=google.com; s=arc-20160816;
        b=rvNynNKTFzjCi1oJtA/oECL3Yabpvo/pZsy82tIrwEDKJ3KUTyPkZ1eu03jESCWwI9
         bOL+3Iy/LCCy4UcINd1rUr/cqysvK71tQEk31u/v8VFf0XlJ8An5TkOCaYAZIp9V241A
         3S7qvSsNWFkz/3tUnJ5HJHkS25N1cUkHgqmfytqT8enaQsE53d1o2nO8/XuRezFbQF2r
         E7TLIAsjQtjuFluJSlSal9XDoJ89T+qE4OGmRA9PQd4IXgce+eUOdj0MsPCNMjzS6gCM
         A5n0239X1uGDk67tMMl20BTuRXLuXBEwvwyKRM3Lf9apdC/AI0qwdM/cG/HfnrJI4QWJ
         V3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5ZCQUHq5It75/cUkkT67sOCIEtBAjlvxbld5Uc+whp0=;
        b=AFAbXKeKbD2J0cUig73CPLhS7JZlE2D7zOPJVjaqyoR/NHgkdpm62grQtuizI/1jUJ
         knw0MPNaulbbicLULXfyoOKRDTnKKnMGX3ojcn8B8W7LtUvyVZ0h4YH8kBOReGHQyB5h
         puLOGpsWBr2R2gYUw0WzitaTtHyV+rdmmi8lELX492Jic49GI+9/DrXMpUMQow42dLJq
         SAHT6sdYe9ZzBzObzfusUJWm1dy72zDbMDec5dAFNJancArTJkinTJwbasfLDJh+UHp9
         Pkr1Y2w+Yrfe6ARBv7pmEAAxKHGvO43mrDvvwcoWawerbJ8sLQlmN0nN9XhbK38VPZY0
         tbeA==
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
Subject: [PATCH 4.15 006/163] IB/core: Fix ib_wc structure size to remain in 64 bytes boundary
Date: Wed, 21 Feb 2018 13:47:15 +0100
Message-Id: <20180221124530.307032354@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015481822044558?=
X-GMAIL-MSGID: =?utf-8?q?1593015940544717334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -983,9 +983,9 @@ struct ib_wc {
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
