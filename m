Return-Path: <kernel-hardening-return-12514-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtav7Tk/vFtSzaRxSNmnofX/Bjte4XjyyDjF+Dqcmy1yFZzAxoXTbtfRnqPUKWY3fYSDpOY
ARC-Seal: i=1; a=rsa-sha256; t=1520970657; cv=none;
        d=google.com; s=arc-20160816;
        b=PDVcMzYWvAzgDS3v9v+SwQFl8xEQ9UgIklG2QI0+VV/jDWFhHn1/y3K0L500j2EFXy
         tPD5w1/mZr8DgoK0MPLNYC8nxUzmTfPyGriVbdsnp3Oscq1AZoVd5wIOj6KQbpV0vz61
         bKvAGZiflszHbE/4otsGdzykMip4s9lh9QCqUJrVVzUiOmdj8yDBY43FykqLAQ6WMipJ
         8nEeCvezsVN+w0JhdSOe8Uz7jiMHSQtNnsNiuWL82tvlKzOZajq3nivSxVxshTaBw+kR
         3P8Af1vd0FyWpTgByDYswzxfqIPBLe29PG+K+ZjS+MP7xGVOc3p2nFUhNxCpHStCUqRr
         ImEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=z3LpzP0/rt/gJXoQPm132osZo5pA7pNwvqGehVEpDeI=;
        b=QK44QTP0L3+kRm4nY4m90tLLdrBuZeemjqBoZ6TwHOtNMs/0+hBVWiUeG1Xs88VUqY
         j/xCJzocoZPf2RuxOgQbUsV+9NqUBPKP5jWdJVt82XL9rXIvqI2RYzG3wfhEXjWjyezw
         Ru7oNuiM70usvDLj8UOKWLf6OlTwioAat76b2zytnP9cWR0kx4R0CM1L70qNKaUSMoCA
         +FHOSFJJQeopYgxTh34MuAgT8TRNN1VuWyWrmyFGwfJP69hHWnX39XFd7Q7ETQu5ATIN
         81x4QOc7NVpg4euMpKBWUXcX1YpTvZds/WuyJ2m9FQ0VA7K1uPGknfM2sqf30u8LWM4N
         4spQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RrfBxtQd;
       spf=pass (google.com: domain of kernel-hardening-return-12514-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12514-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RrfBxtQd;
       spf=pass (google.com: domain of kernel-hardening-return-12514-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12514-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	linux-btrfs@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <jbacik@fb.com>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: [PATCH] Btrfs: drop a VLA in btrfs_check_super_csum()
Date: Tue, 13 Mar 2018 20:50:22 +0100
Message-Id: <1520970622-19535-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853328339341486?=
X-GMAIL-MSGID: =?utf-8?q?1594853328339341486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid a VLA[1] by using a real constant expression instead of a variable.
The compiler should be able to optimize the original code and avoid using
an actual VLA. Anyway this change is useful because it will avoid a false
positive with -Wvla, it might also help the compiler generating better
code.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 21f34ad..88cef92 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -403,8 +403,7 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 
 	if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
 		u32 crc = ~(u32)0;
-		const int csum_size = sizeof(crc);
-		char result[csum_size];
+		char result[sizeof(crc)];
 
 		/*
 		 * The super_block structure does not span the whole
@@ -415,7 +414,7 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 				crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		btrfs_csum_final(crc, result);
 
-		if (memcmp(raw_disk_sb, result, csum_size))
+		if (memcmp(raw_disk_sb, result, sizeof(result)))
 			ret = 1;
 	}
 
-- 
1.9.1
