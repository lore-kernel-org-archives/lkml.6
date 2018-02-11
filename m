Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225VNmZro+Iuhml6Y9ovUtl1rTfaPocCLGF57F91SW4HfGkcxKuR5dcxnHCih6Q8P6Gov4kE
ARC-Seal: i=1; a=rsa-sha256; t=1518323640; cv=none;
        d=google.com; s=arc-20160816;
        b=cd6Q0G5AfBQYRjSPiiKgM6tfcrIqp26Pi3NjJFYKPCodnU1qQFYD5mJYzyyKFoU+8h
         PZ83/Vq9WwnNrmkrK+BJFECCikS1fOMOgCkHLxfPtZ0zXM0oSaONC2ooJ07ohjWUbSb2
         hdlIp4wCA30nXrXOjUy2yPNRSqLarDzRvQv8RHt8zqeXI37LXgJojQoWq3HnF9yHsnnL
         omTPlKX6F9uDu24zyZ0kfNBLzZfjrldCOMGFQbcKe6SdatOrLCkHiHidhba47mlo+XqE
         voXQUtw2p7Tzk0cUl2FjS00B+DjpLSJeUjBMP+wdD4CxIDvTrNi5dEPh72/A8Nw2l/wk
         VH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=+l5+Jx4CR8niNau1W+0WvbLwkvBAQK2mKkRVS6E9Gx4=;
        b=x53EltqF6dmqjCqTwZfiLrxAsseEGBixIHfNgaKJi8LkyhkBVUjAeUuXkriPfCmMOv
         akNvUSmtxCZTvvCSTAfAr0nTPvFzTWOcj/mnyVgLcDM7x3F6iqeKz+9ujQ8CUJQ3iNLX
         9+pZEIfvcImYi/9qa7u3HUNT4Qm1ZdG+NR4V16kxUx5puXyh1PuKzHcqEgFn7TIszkQh
         aOhMoN1Y90OHMCUTpDp13WY4fGfKYSDcI74wAYLmnbwA3IpLIsNhEaRLvpGit2CoiiYO
         FnLTzn7Jwcr161Zd8nUI7rV694aWRT+rswrbCe/WyA2SRj9udnGKgWR9ylYF0ZO4L1N7
         jb8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Viktor Slavkovic" <viktors@google.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.875907406@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 116/136] staging: android: ashmem: fix a race
 condition in ASHMEM_SET_SIZE ioctl
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077729711315594?=
X-GMAIL-MSGID: =?utf-8?q?1592077729711315594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Viktor Slavkovic <viktors@google.com>

commit 443064cb0b1fb4569fe0a71209da7625129fb760 upstream.

A lock-unlock is missing in ASHMEM_SET_SIZE ioctl which can result in a
race condition when mmap is called. After the !asma->file check, before
setting asma->size, asma->file can be set in mmap. That would result in
having different asma->size than the mapped memory size. Combined with
ASHMEM_UNPIN ioctl and shrinker invocation, this can result in memory
corruption.

Signed-off-by: Viktor Slavkovic <viktors@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/android/ashmem.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -758,10 +758,12 @@ static long ashmem_ioctl(struct file *fi
 		break;
 	case ASHMEM_SET_SIZE:
 		ret = -EINVAL;
+		mutex_lock(&ashmem_mutex);
 		if (!asma->file) {
 			ret = 0;
 			asma->size = (size_t) arg;
 		}
+		mutex_unlock(&ashmem_mutex);
 		break;
 	case ASHMEM_GET_SIZE:
 		ret = asma->size;
