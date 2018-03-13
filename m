Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu2a8VgvuJrQ0DOIZytE9v9nYJazTrbieINWEQLH33mV/2fGXvCmlygYyWp7s/nTDmzKwmS
ARC-Seal: i=1; a=rsa-sha256; t=1520954961; cv=none;
        d=google.com; s=arc-20160816;
        b=eZOySQjTJ0fzbMTLb7bZopMN5qftmOzVf94nOX1WqXsXjC//ZiBE7YVXdgkAWD0lXh
         VPkrUkEEOfBdT6x8kCPndJ2BQ10w9ooT32W+D2VxJxIH7lN6VjVTdPCrrB4BsECWbqbV
         asl3QGMG/yN4VUPtxuj+O1a+DifWWQtblF/OhSHXq/zMfbmnXzXdW5ocYQzxwtgm3yxJ
         WuMyJY8YBoZgvWAnA13lEmG53oq7iyZKlN5StSFrE173PGCVExFRKOm/9p4ce9p3hpxr
         MTpkuUQGWp+wgBSwjDd1zHjZBJ4/icYNEM6MrZ8U/0tgpjqEBDnWI2NdgRn6vf1FQIyh
         BLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lK922/lm+jk6dEQgfcgIDkKyKSWomKOkz/qMHaIZK/Q=;
        b=L1rNUSoar60ymB1V/le4zcdjreLS/HpLa60EY/K7wlUMG9dYKT2FUCnD2X6laLIsQ9
         MXYmhp+AdhcfDQ2Rb1YNxfMScvQOrQMIq2nz7yVn5IXOynEny/6b9icRMMgCs47WAXFl
         gF0O1+5uBQY2h7760bcw2KAYZXMYC6G5sRIQsDHgeNw3i9+rvcJU/poGA4e6gq6udaQk
         k0lUadzDChYpnOcU14rwPiZjn1ICG4tHDNiXKc4+hAye7jT8/k88SE5J6F+OXrPP8iVk
         AQj5NEAKi7s15Jfunt8QZjEJ0t5CEHwv5pnPCVz4m4ENpjjkW9AhVCrHhzSAirF24kt5
         bwMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 041/146] MIPS: ath25: Check for kzalloc allocation failure
Date: Tue, 13 Mar 2018 16:23:28 +0100
Message-Id: <20180313152323.760025151@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836869836230255?=
X-GMAIL-MSGID: =?utf-8?q?1594836869836230255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 1b22b4b28fd5fbc51855219e3238b3ab81da8466 upstream.

Currently there is no null check on a failed allocation of board_data,
and hence a null pointer dereference will occurr. Fix this by checking
for the out of memory null pointer.

Fixes: a7473717483e ("MIPS: ath25: add board configuration detection")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.19+
Patchwork: https://patchwork.linux-mips.org/patch/18657/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath25/board.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -135,6 +135,8 @@ int __init ath25_find_config(phys_addr_t
 	}
 
 	board_data = kzalloc(BOARD_CONFIG_BUFSZ, GFP_KERNEL);
+	if (!board_data)
+		goto error;
 	ath25_board.config = (struct ath25_boarddata *)board_data;
 	memcpy_fromio(board_data, bcfg, 0x100);
 	if (broken_boarddata) {
