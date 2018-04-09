Return-Path: <kernel-hardening-return-12925-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49p0wOWo+tNmzl4rEsVECnd3NcTE6/VSQaYp7hoFTrwg2FgZnrLo9N7+ZCSk5jCT6wCeYJh
ARC-Seal: i=1; a=rsa-sha256; t=1523282164; cv=none;
        d=google.com; s=arc-20160816;
        b=AXsdPDAbhX7QDbNgZ0QL2xjEClQE1kDu/TuOXK4IuEZGEWvv0FADQvQzub4s/0ipLH
         gbgXv30CJ+jchaCDYJgWhQmUkKfKS7kYEl0ojJAF2u6DV1gEkppb40XntWvrWON1hidf
         Z4AR7yYgl/lD49PQ9c+SVZdA+V+3hAQy6+5lCCh3wzuhVuigeCUq6y9TUBWwf7oJeAAM
         QGJGGFEEeKHxAWSEviDzag+iXkzDp0tn8LoBPSYW9F2JruhcaASfBzUvjq9ZfgjWU8zO
         NqVebi47ShKtfEwQvduZquMVbwfsGzvDXbtsuy2Hb11i3worDb/8/KoCdafbObllQ9hY
         38Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Oo2uLWTCE8StpZI/d1MWTuUbCp5v/WRHYUH17ozAirs=;
        b=VKHPhWgcYtufz0htNuAWTxM6+MBFYSSXof/U/u3EUIIa5gjrTYZTqFxcRp4iR8w3d9
         wuWVwK6XxJZ9D8Z3GeKx9lIVvRnvP1GvL6aIfuEmxfyBZrWsE6b60zsyuluAqcENh2Gp
         jultfToZ3g2JBeHR/JvjgHB1pRtzlJ7ZQdP6fW69LCogZZV/DCqIluoLrBktG7ULyMDp
         h4hecPtl14qcJH/X2C92TUhsjcD5UUZR6+5xdXqM/g0d2oH+CX9td6GOv54FSy1nGQ+0
         DqiustSNDiHR13nqyNCIJgpK/vyzS5kNIkWj/0jj62K4HWHSNXtlZZnGHQkc2AudE409
         /48Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HOEMqYvb;
       spf=pass (google.com: domain of kernel-hardening-return-12925-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12925-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HOEMqYvb;
       spf=pass (google.com: domain of kernel-hardening-return-12925-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12925-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v2 0/2] crypto: removing various VLAs
Date: Mon,  9 Apr 2018 15:54:45 +0200
Message-Id: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277119052489301?=
X-GMAIL-MSGID: =?utf-8?q?1597277119052489301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

v2:
	As suggested by Herbert Xu, the blocksize and alignmask checks
	have been moved to crypto_check_alg.
	So, now, all the other separate checks are not necessary.
	Also, the defines have been moved to include/crypto/algapi.h.

v1:
	As suggested by Laura Abbott[1], I'm resending my patch with
	MAX_BLOCKSIZE and MAX_ALIGNMASK defined in an header, so they
	can be used in other places.
	I took this opportunity to deal with some other VLAs not
	handled in the old patch.

[1] http://lkml.kernel.org/r/4e536889-439a-49e6-dd95-2d4286913202@redhat.com

Salvatore Mesoraca (2):
  crypto: api - laying defines and checks for statically allocated
    buffers
  crypto: remove several VLAs

 crypto/algapi.c         | 10 ++++++++++
 crypto/cfb.c            |  7 +++----
 crypto/cipher.c         |  3 ++-
 crypto/ctr.c            |  4 ++--
 crypto/cts.c            |  5 +++--
 crypto/pcbc.c           |  5 +++--
 include/crypto/algapi.h |  8 ++++++++
 7 files changed, 31 insertions(+), 11 deletions(-)

-- 
1.9.1
