Return-Path: <kernel-hardening-return-12620-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuSXQPZOQs0xU0DbTCN43zPavuzaOXaPahCvTYmJXIKt8Aw76lsj3Do6pC2gyZFTj6/+f8U
ARC-Seal: i=1; a=rsa-sha256; t=1521088668; cv=none;
        d=google.com; s=arc-20160816;
        b=dIDKeA/H1p2eOJXXPzXMeCTKjCYA3eZqchaHL/2NNoHXojLVbCbMrsWKJa6n8/YFMd
         D4CH+sBVbC8pHbFndTYO68NUhJD2tHexanOB81eTCpjlDkn4L39f/onm4WKUpNRJFH3x
         ifu8ZCUy69coSINXt+c8VRgGrQrk8D7XNy6ftPJvs5oHvvZTweowK4ZJ8Zyq4QLYoVGN
         Hx2y5aW5ElST20mZBByErEkktZRuNEvv19t5hhRt01IZsD/R1CL9zR0irEzYbMyN75uc
         sMcGoFyiUwankTAO4vktJMtvelNDtoz+wH484sBjZa05qWBXYm4TORSmnMx085uJC0RG
         uEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:from:subject:cc:to:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=sixVjZpVkmOLpduTVlXGinQtPSbiIZv32/WJMDUcM08=;
        b=wQEcgV6GMLnuwRVe04NekCCsG0+7tkgD1rG0/ENLdLRHAlB78TUlRomWC+IZdyACBt
         kHzsFtfG+5FrgjD3Es/IdMGKJCpUZCxpxssVEHdGIl/t84Ai8hxfSMe+vgc3oAPg6a4D
         lRFcUheRzNL6DMqio7ZK/IzdnVTXqaCR5pVlxGyOGT423IkaXM9SwQOw1erokVaPmKTZ
         a+ZAxeuilFhRnH1i5V58p/DteINJ/oVnKa7ZGqFp+WIeaKwJqzPkadCisbCN0A/+6YhS
         ZNkuec2E2C5BldTXqOmyNIvYyZGEBDcrV2jMQGxh9fygvuSxk+NDQAa3vbc3filbX5z8
         IOlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=J0By+pPy;
       spf=pass (google.com: domain of kernel-hardening-return-12620-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12620-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=J0By+pPy;
       spf=pass (google.com: domain of kernel-hardening-return-12620-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12620-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
To: Stephen Kitt <steve@sk2.org>
Cc: hare@suse.com, linux-scsi@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bfa: remove VLA
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180308213841.13807-1-steve@sk2.org>
Date: Thu, 15 Mar 2018 00:37:20 -0400
In-Reply-To: <20180308213841.13807-1-steve@sk2.org> (Stephen Kitt's message of
	"Thu, 8 Mar 2018 22:38:41 +0100")
Message-ID: <yq18tau7y4f.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=451
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150053
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407144538028292?=
X-GMAIL-MSGID: =?utf-8?q?1594977071414898815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Stephen,

> bfad_bsg.c uses a variable-length array declaration to measure the
> size of a putative array; this can be replaced by the product of the
> size of an element and the number of elements, avoiding the VLA
> altogether.
>
> -		sizeof(wwn_t[iocmd->nports])) != BFA_STATUS_OK) {
> +		sizeof(wwn_t) * iocmd->nports) != BFA_STATUS_OK) {

These parentheses made me blurry eyed but it's actually OK.

Applied to 4.17/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
