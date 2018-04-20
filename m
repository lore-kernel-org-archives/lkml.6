Return-Path: <kernel-hardening-return-13070-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrfN4UWO88zUSmbChGZGeMzUxqM85hvSMAEem+OsTeT0q2L689KRGTOs6GRRFMqE/xQdy33
ARC-Seal: i=1; a=rsa-sha256; t=1524243126; cv=none;
        d=google.com; s=arc-20160816;
        b=VcFw1sITzF9QN58qPKhrOw0Mf4ZgYe/OdElCVsIHRxPt7+yUGHqTJPTj2Etv7ismyP
         icQSo5Or6Gr2sBnr32TkPpePgmSJIQZ2aqORH0PFCn7HAhC9nDdIgst8agrU2RctKp/X
         FJS78zt4jsSX0VIYrtg3iljUaB/CEc5FPjy+GATUE0ESDwaRHuGKMX3daU0zoT9duQ0X
         gmwmYysUAdZPTxQne+xlnQA29VG5oVjfIlNlYM1kuM2rLbQuPE5nsG0R2TV2/wWhbA0o
         FdfCWajxlxAB4itLmcl2Hogve/hNmPfIAqInVCDO81Mm3iC15Q1dMqWoLTtENXTepF/V
         +HoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=IzTtJ+CYGFlpyB4eLSDXUuAR8Xqk8FKE82q2mSwpcIU=;
        b=Ql23pyBNQhS1Old29kGdbJeV2yFXuIs7X3IQzwXEjVqeaeNO0I9cZ5U4lgGbDNazsD
         zABvQMwC7hg5T+fTL9OcNWGKuRxkBru2fJSHQ35cuAJ2xIrbSno3oXd1R3QPZikChxR4
         ptrHtZYrPnQSUio1/z6Mh66f8RRRZ0t2GMuJfDJ1PwDp4EuIC0VnU8bQO5vI353w7HI7
         jf1RNZEAcsdwUMUGn2Z4BgsOZhk5TmujvPqbK1n2hBjJKpnCATvIrtDwmOY0CSelB/o/
         C7jD5aQMPSjzAV5tuB2S53IThhCzVmanJmmlBWPUQ2ZNluXzglMVSXTtNriTnl3gRUEI
         lPtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13070-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13070-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13070-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13070-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 21 Apr 2018 00:51:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH v2 0/2] crypto: removing various VLAs
Message-ID: <20180420165143.mwcxwkf6j7ddckdt@gondor.apana.org.au>
References: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277119052489301?=
X-GMAIL-MSGID: =?utf-8?q?1598284760804323825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 03:54:45PM +0200, Salvatore Mesoraca wrote:
> v2:
> 	As suggested by Herbert Xu, the blocksize and alignmask checks
> 	have been moved to crypto_check_alg.
> 	So, now, all the other separate checks are not necessary.
> 	Also, the defines have been moved to include/crypto/algapi.h.
> 
> v1:
> 	As suggested by Laura Abbott[1], I'm resending my patch with
> 	MAX_BLOCKSIZE and MAX_ALIGNMASK defined in an header, so they
> 	can be used in other places.
> 	I took this opportunity to deal with some other VLAs not
> 	handled in the old patch.
> 
> [1] http://lkml.kernel.org/r/4e536889-439a-49e6-dd95-2d4286913202@redhat.com
> 
> Salvatore Mesoraca (2):
>   crypto: api - laying defines and checks for statically allocated
>     buffers
>   crypto: remove several VLAs
> 
>  crypto/algapi.c         | 10 ++++++++++
>  crypto/cfb.c            |  7 +++----
>  crypto/cipher.c         |  3 ++-
>  crypto/ctr.c            |  4 ++--
>  crypto/cts.c            |  5 +++--
>  crypto/pcbc.c           |  5 +++--
>  include/crypto/algapi.h |  8 ++++++++
>  7 files changed, 31 insertions(+), 11 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
