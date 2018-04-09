Return-Path: <kernel-hardening-return-12918-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49KKYa2CTx4nnnebUv1SbliZ6IqZWCDqpEgtomL76UQqLzgUrAQip3oTlgbWuP7DbJ6JZAu
ARC-Seal: i=1; a=rsa-sha256; t=1523282097; cv=none;
        d=google.com; s=arc-20160816;
        b=hCJ0hETkBUlEypf84rsD33e0S293ZQ6CAkvs1UB2DdBclECxpsBoA8SeyCuLOBEuLj
         p3JrWM01O8gRgwj6nUv3FF/WuT7P6j8T5D77y/N5CpVqNrkQJPujJYif7Mhj22HBjg6u
         SOxfB61hFHRXEwkB4aE1jrnAnj+4HovxKZ2rwPiKTX8zaKxaDpvDrlE7z87yXX3uHunz
         iJz3lOwoUxaFj17bERrp8HdDwj599LPtT7LYwJ6QJcrj5bIxjUT+xmqeLttovOZHRO9l
         KzaI+dhCVPsLsIqPVNMfcLejg2+nE5JeAgAHOd53Kd+gx0FTc76bZvbfiF0VrPtcU1YT
         viRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Eaxm2NIVsuvWf15YbboTg1KrK1/hLMB61bFRYaEO5uQ=;
        b=PnG9TTv3Gplx8J/E/8Ndbp3gYsrSi9DkP9ACv8R70JGogBhijcAADaWlBeSAvt62r8
         7Pi9mfDmlHz0V83TnvNjMvWci5rQ+lAsyAUjcCEjJkUQ3o7D4fw6ofsOZ3RAatjAOCDA
         o9f3XNPdfxOH8AUEJP2T7W4tjR04oJoV/R4n6+giY62Fg7qyykc8SMOW803nicOpH2Uf
         5Va6KEb0tp2BjLJODCSSYsZ39rwDT0xjAIIjd65CCETvltkWt+LbgaojvnR8xyHu5yB2
         Yho0xW20uD2uf70T2aZ+B6DZt1ASMjp4NK62qaqXLwGIRARi5ytzjmyPcRggXZjvM7DE
         invA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YN1HjNkD;
       spf=pass (google.com: domain of kernel-hardening-return-12918-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12918-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YN1HjNkD;
       spf=pass (google.com: domain of kernel-hardening-return-12918-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12918-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: [PATCH 0/6] Remove several VLAs in the crypto subsystem
Date: Mon,  9 Apr 2018 15:53:58 +0200
Message-Id: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277047906530259?=
X-GMAIL-MSGID: =?utf-8?q?1597277047906530259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As suggested by Laura Abbott[2], I'm resending my patch with
MAX_BLOCKSIZE and MAX_ALIGNMASK defined in an header, so they
can be used in other places.
I take this opportuinuty to deal with some other VLAs not
handled in the old patch.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
[2] http://lkml.kernel.org/r/4e536889-439a-49e6-dd95-2d4286913202@redhat.com

Salvatore Mesoraca (6):
  crypto: api - laying macros for statically allocated buffers
  crypto: ctr - avoid VLA use
  crypto: api - avoid VLA use
  crypto: pcbc - avoid VLA use
  crypto: cts - avoid VLA use
  crypto: cfb - avoid VLA use

 crypto/cfb.c      | 14 ++++++++++----
 crypto/cipher.c   |  7 ++++++-
 crypto/ctr.c      | 13 +++++++++++--
 crypto/cts.c      |  8 ++++++--
 crypto/internal.h |  8 ++++++++
 crypto/pcbc.c     |  9 +++++++--
 6 files changed, 48 insertions(+), 11 deletions(-)

-- 
1.9.1
