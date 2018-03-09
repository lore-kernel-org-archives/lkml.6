Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520633582; cv=none;
        d=google.com; s=arc-20160816;
        b=Luozn24KJIlceOwitllV4i4SyBeve4et1wF3eDVkXEXkal3ZNGEvF968ukOXvBRjCn
         rZlwX+yVR5xEMV2CdFedzpmsE/xmmXDYBg/hfgVHa6e6GQS4ccyZjb1A9fgS/KvR0yb2
         RDUWWKFPd143bN598dL3B0DYxlVUjn8n09U8bTsizYMiRQUWy0vF0DY9HjxNbT2p0q54
         rAOfNzht4LGc1JELbi+p8urkHz3DvV/e7NZeteuJWnC32M4MfqtCR2EN16R+8HQubufv
         G+JhpjoCX0Vy0sJe99hAnTEqMi8o3kEe/UrAarv9iY3kQYkVhbOqEBY/tUOabqBFAl/m
         EZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4dxjdXNul0QkLH8K1xo3oETxMmZewlLZnXLngt/AQ9c=;
        b=VHvB48pUgT3FZg3rNAahkOjvsySMnym3VRR4L+epN6spHMtE3wkwo5FHUXkAwSdqSQ
         6vwxulUPBC67wxv0kklHIGPfWKxn+6cBB14Ar7OncZErcbg1619KB1WfearnylEtxHOW
         gxkP6fH/4ey4dKX5oiD6b5mDGE1INSORyURqax7MKAL0umuOYpp1990/mPpB5jD5XYFQ
         8Rj5cr6/3mVYfVNMPTvGNqU/hBw4p/GPk4Rb2BhzD/QL5dRex9X8Ebv702aM5TMWBvcP
         OEeZeru1rTT5cK1XQh0K08T0tS8Jj5/ILvsJdg/tcXCeIHc91AA1oQjCGDo3yJcW07y2
         YqDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rr6aYp73;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rr6aYp73;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuI5gSe+r7L3z+LQDTOspJ0W0NJP7+Wj3bMLtQX9OO1o8sCV1SFD3SqFRvFNDkdWIIAet0YlQ==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org
Subject: [RFC 0/1] Loading optional firmware
Date: Fri,  9 Mar 2018 17:12:42 -0500
Message-Id: <20180309221243.15489-1-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594499879677109400?=
X-GMAIL-MSGID: =?utf-8?q?1594499879677109400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Everyone,

Wanted to inquire your opinions about the following matter.

We are experiencing some end user confusion regarding the following messages
being printed to dmesg:

[    0.571324] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_pfp_2.bin failed with error -2
[    0.571338] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_me_2.bin failed with error -2
[    0.571348] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_ce_2.bin failed with error -2
[    0.571366] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_mec_2.bin failed with error -2
[    0.571404] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_mec2_2.bin failed with error -2

These firmware blobs are optional. If they aren't available, the graphics card
can still function normally. But having these messages causes the user to think
their current problems are related to missing firmware.

It would be great if we could have a mechanism that enabled us to load a
firmware blob without any dmesg spew in case of file not found errors.Currently
request_firmware_direct() implements this functionality, but as a drawback it
forfeits the usermodehelper fallback path.

As part of this series, there is a small patch to enable
request_firmware_optional(), which has the same logging behaviour as
request_firmware_direct(), but will maintain the usermodehelper fallback.

Let me know if you find this change suitable, or if you would prefer a
different strategy to tackle this issue.

Andres Rodriguez (1):
  firmware: add a function to load optional firmware

 drivers/base/firmware_class.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
2.14.1
