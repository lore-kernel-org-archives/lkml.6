Return-Path: <kernel-hardening-return-13141-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZp5NygyTE5RJVzbGlk9W+RBms3deBgsVbnP2UQ3ZBCpa2evROTSy0CnrS3Ivz0PQUPr9GE1
ARC-Seal: i=1; a=rsa-sha256; t=1524668359; cv=none;
        d=google.com; s=arc-20160816;
        b=BSzftr3KJREu5SuSIBQ13jKr/5AI5JBT/IsRcGqWvFHvORawbGaGSxGWnCCS78tnhx
         RYzxXBqWOUXz4uZqOGQqC4L3Z9d2vHoklAbA3cv+oWwGil/R9IKad0hk2G7GXhBKQzFb
         RW2Ap9QHt/s91WJXqN27YqhHSUmwoOEzVb/4vRI+S5Va4blcHiDP8KccBv+GRCHsYzN1
         6CA0wgsYdptAS/PtFn3CmpvBvmDKEQP6q1Vg7e4FKRygO3k8OFCnNR71kdBOA86vmbM9
         mbYg76l6obGYIUkjYFYH1wtrtNSbmrtEEioNl9Ba1wZDsbZROOZx2pBC8dF4X3eBm2n5
         wa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=I4RDPjqxe/eoIegxRKduRul/QwAHixAHc8TPyMtAhGc=;
        b=Aph5dpKkxttH5mRAMPBAOK/TZeriJZ0YMAEt/jrsrMdN3z4ew/6Gb4z4GjEnAMnbh8
         R2sbda/qLnFdVQXawcYue/6T8MA++J2sF8U8h15HvD/CvrTEHzhDlyvd0Evcf3d7I+C1
         9F5YWRu6GGzMPZZYFh4rZ3Vuhn6io3jYYSYF2/z2gJEh0Y8GSaOBZjV7cWigiZyT/hZ6
         iB20tOkBkJ11KJmI2unl+ZvKyKQo9FnmLK9DN1tjHUWbextJMd0hJF40fO27ttk43kh4
         wkseknhPy4d/dWw/8HgfD6fpdlsjXyPZ+eHgC/Mc2cN5tYyL58vPHPfJh3WM27gvoaQN
         5fIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13141-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13141-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13141-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13141-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 25 Apr 2018 16:58:52 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,
 kernel-hardening@lists.openwall.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
 <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 ipsec-next] xfrm: remove VLA usage in __xfrm6_sort()
Message-ID: <20180425165852.6c7460c2@epycfail>
In-Reply-To: <20180425144639.GA38350@beast>
References: <20180425144639.GA38350@beast>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598729875203857448?=
X-GMAIL-MSGID: =?utf-8?q?1598730649130787603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018 07:46:39 -0700
Kees Cook <keescook@chromium.org> wrote:

> In the quest to remove all stack VLA usage removed from the kernel[1],
> just use XFRM_MAX_DEPTH as already done for the "class" array. In one
> case, it'll do this loop up to 5, the other caller up to 6.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Co-developed-by: Andreas Christoforou <andreaschristofo@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v4:
> - actually remove memset(). :)
> v3:
> - adjust Subject and commit log (Steffen)
> - use "= { }" instead of memset() (Stefano)
> v2:
> - use XFRM_MAX_DEPTH for "count" array (Steffen and Mathias).
> ---

Acked-by: Stefano Brivio <sbrivio@redhat.com>
