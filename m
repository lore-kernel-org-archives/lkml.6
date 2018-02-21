Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225WJ4Pln5rO/49fXX0mjGX7R1xXnOC2J+K45ZZ47VpVBjJxdQtOh/7nQVDxdhC+xOGRTiCk
ARC-Seal: i=1; a=rsa-sha256; t=1519217733; cv=none;
        d=google.com; s=arc-20160816;
        b=xFR9JyauJHZjoFS0HQ0DFixqHRkR9tt7OgBrq2AIoql1RpLvR+21QlHQaD4WP476JJ
         a3oNfg88sp4qgiCNeqJJP2+IH1Dr4O/Q2je1FRJgk+M3qg+Yb2rjotPI0eMh2dYXMWqn
         rKAscRCErW7kC8xP35vuh2BT9EhEgdGhQ97hd+EvurrTsZeQWkW9egWm6yjzklwXUcfW
         bT5eSi3o+8ysR0/yqc/MV9HG/Q7ZEUR6gNX6RQZqI2JCmP/RF8keStTcgKVoXkKV4qyE
         C4pJ19ESFwN7ipVp+n9l2oz+qII/xyUhtggccP20f+vT3YHAQIzUyvag3HYbw+bYcKbS
         FeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=66/yDDJmFU04YoiDsPVnv8WNv/3PXvqJwS7XRc1uQZI=;
        b=YpdXF/jd4ZZgNVgW7aRj1ea1I95XvGeP3C08i1A/8MImXMs49DWk6mEVTlNKbvSlDF
         TMlJDRyWn5x3OIRCZ+IFU3MQbBehBJUpnwW0pGgrHtdV4+xxZD0QlzUoYBkFUFwDTN0c
         N/GXEdYnbUdfP8EAr7gnmm9qkDJrfBmpG4vc/ZfwPy7IOPXQQ+u0AKtqf9PJQjGx048k
         lvLHYDqIm6a0QMhwfqf1kOOTvhWZ8TB8C4ATGtoNjgXmCfM92ZhptYJg54LKxLEuBbeX
         4s0xEC4Qan3UeKHrJyPeBDThy4ehf0YfTCFJ2yywQyZ54kIWYCT9BLF3z4vvI/3AQmYB
         a1Gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 08/77] ext4: save error to disk in __ext4_grp_locked_error()
Date: Wed, 21 Feb 2018 13:48:17 +0100
Message-Id: <20180221124432.521698126@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014620343797175?=
X-GMAIL-MSGID: =?utf-8?q?1593015254602546777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

commit 06f29cc81f0350261f59643a505010531130eea0 upstream.

In the function __ext4_grp_locked_error(), __save_error_info()
is called to save error info in super block block, but does not sync
that information to disk to info the subsequence fsck after reboot.

This patch writes the error information to disk.  After this patch,
I think there is no obvious EXT4 error handle branches which leads to
"Remounting filesystem read-only" will leave the disk partition miss
the subsequence fsck.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -720,6 +720,7 @@ __acquires(bitlock)
 	}
 
 	ext4_unlock_group(sb, grp);
+	ext4_commit_super(sb, 1);
 	ext4_handle_error(sb);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
