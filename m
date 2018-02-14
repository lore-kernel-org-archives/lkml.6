Return-Path: <kernel-hardening-return-11755-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2258LhFPSbDpaXdjxXXj0lN02t7Lo0zMEZsfuz0UcQCWxaQTc1NP0CegPjb5xceDGzyHt9fT
ARC-Seal: i=1; a=rsa-sha256; t=1518632838; cv=none;
        d=google.com; s=arc-20160816;
        b=g9B9ovPuzFS+iswOGzrj8mDdpDBrrzp8ra5yEs33iPOjJ2C9P8qDIi1XjPKA6KTG/X
         EqxCrxwW/M6jbfrKL0YjGBmgzBfzFs4PuVyCxP9v847z1jdtM/vtdZ26bAmwisptp3XY
         IC4ROvSraV/uLiKOZEarf680Tztn+dUR1TS7KJhdju2N2GW+52+KptxyjHM7N6BmdBU4
         zfK79JVc3kwom5e7rU/oG8gV4B9wB+hyVDGEn54cIwJs8hu+sGscnyBFLc/sBHiCIF/8
         jV4BLUd5EwM5lQPsKuaEThPK9OWOSOiMz3AO3fgk8h4yt25ma1X19xKux+QPIOvkGVjP
         vsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=8EvrJzML4QbyIGOABtDwyZ9IvULxh4uqpwPOtxh3Av8=;
        b=aKmBuwyolaJeJFFQ8/PS9KzcI387OKtIG6EuYCN38SiEClL5koSMLio3gXRau7lGeQ
         narfdF5wGGIWM6JndcfVXG16KZ7yedokqXFzbj3U1mp8WwEd3anfCiM23eF9bQz+mmjr
         +je3u+pDjxr14OMDVDrftkSF7ELCg3/Z3E3jBun90GZHbPz6eS4qmZhpi572BPcSXpg3
         RP1HEKu0U/ULOP0jqC02Gff99pOS1SxumJ8DYfeJqRIZGe9ZfmhO8EHQmq0CZvNSpXeD
         /ncQ8CCTe91VkCuxdn2I7kRy7L5rUDkZBg6DYok/9P+2ojQdmOEcC4fuOrjxm8w3arl4
         pIIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=D9CmX33+;
       spf=pass (google.com: domain of kernel-hardening-return-11755-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11755-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=D9CmX33+;
       spf=pass (google.com: domain of kernel-hardening-return-11755-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11755-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH 0/2] Add kvzalloc_struct to complement kvzalloc_array
Date: Wed, 14 Feb 2018 10:26:16 -0800
Message-Id: <20180214182618.14627-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401947833736714?=
X-GMAIL-MSGID: =?utf-8?q?1592401947833736714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

We all know the perils of multiplying a value provided from userspace
by a constant and then allocating the resulting number of bytes.  That's
why we have kvmalloc_array(), so we don't have to think about it.
This solves the same problem when we embed one of these arrays in a
struct like this:

struct {
	int n;
	unsigned long array[];
};

Using kvzalloc_struct() to allocate this will save precious thinking
time and reduce the possibilities of bugs.

Matthew Wilcox (2):
  mm: Add kernel-doc for kvfree
  mm: Add kvmalloc_ab_c and kvzalloc_struct

 include/linux/mm.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/util.c          | 10 ++++++++++
 2 files changed, 61 insertions(+)

-- 
2.15.1
