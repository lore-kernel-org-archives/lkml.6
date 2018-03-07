Return-Path: <kernel-hardening-return-12199-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvm/AUIoI51a7vQ/h1XD9Ac3snWjjDzi+bmaf//ROqt9nXXleI5wbQmlqaUX0N2MDhOdUiw
ARC-Seal: i=1; a=rsa-sha256; t=1520437672; cv=none;
        d=google.com; s=arc-20160816;
        b=PHEDt3yu8mQNWQcnI1VN4TNPLgMy2rQLmtKIPGrwoKpb+uIihRXxub8RNOSfTEPb4P
         DedEC5RWYL+pgEEesMTa8BoWbTRq9KBiwJJFYBFPC+3hIiHZ+MlPJVJO2CoAOiKSJDqk
         A74H+7wAyuv6uzyLLbBkcwh6SBScyoBynI2GEW3xviZY59kgcjJ+6RiTt60JWbHVAfp0
         pr/K2z4glSVNN7RBTTOKvF1xo/QBRqe7QMRR9wz/034YVDHK32pTIN+zbS7N/v5rDlZm
         OFGuScsl56B8cXdSpe/s6Y8T7ockjSke7InPFydmiMMGJcYotzWBmlwGUf/ywZJD2O9l
         byAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=ww3YQ59NPSBj4icugs5xmJc5UGHuJ2zEHtC6mFmCWj4=;
        b=s9JtIljwUcmu+vbXLKDoa4l76ihiF2hkjrj1fhzG8kECF2dm110eLpre/pGe5qE4M+
         R0Wq/G1/7TBDxgpKiob6+HsFlS8ljNwuHshOzdjoVW3qaVecsuzLgVAzGKMPoU77ZX02
         nKS1+tP4APVGis/hbIwZ+P1EwAWGKuG6IEM6HW1uOhh01cINBEHLS7eKfLJLEevnHTaD
         yyPaV1VJZrth1My5TuVTRaWslUZz1EO4uuEOhnoRjhSP0epBgRzKtJ4ObTOwt3/eyFTd
         E0M2X4NIZ4aHDVrk63v7TAt+TQnHba458pAzC4PhR80xdp6u90sUPZTjYOvgvZYHxKMQ
         HGmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12199-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12199-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12199-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12199-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/7] genalloc: track beginning of allocations
From: Igor Stoppa <igor.stoppa@huawei.com>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: <david@fromorbit.com>, <willy@infradead.org>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-2-igor.stoppa@huawei.com>
 <20180306131856.GD19349@rapoport-lnx>
 <54e95716-9d61-51a3-9ae8-196e60625b76@huawei.com>
Message-ID: <98df3380-a142-871e-5a18-b356088e33ea@huawei.com>
Date: Wed, 7 Mar 2018 17:46:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <54e95716-9d61-51a3-9ae8-196e60625b76@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676614912638441?=
X-GMAIL-MSGID: =?utf-8?q?1594294453305838422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/03/18 16:48, Igor Stoppa wrote:
> 
> 
> On 06/03/18 15:19, Mike Rapoport wrote:
>> On Wed, Feb 28, 2018 at 10:06:14PM +0200, Igor Stoppa wrote:

[...]

>>> + * get_boundary() - verifies address, then measure length.
>>
>> There's some lack of consistency between the name and implementation and
>> the description.
>> It seems that it would be simpler to actually make it get_length() and
>> return the length of the allocation or nentries if the latter is smaller.
>> Then in gen_pool_free() there will be no need to recalculate nentries
>> again.
> 
> There is an error in the documentation. I'll explain below.

Argh, I do not know why I came out with that.

Yes, your comment is correct. I've modified the function accordingly and
it is simpler.

I will post it in the next revision.

--
igor
