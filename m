Return-Path: <kernel-hardening-return-12727-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtCv3ZpXDQiOwUPhs8uxrwEEtmzlYm9N3H4icyLJzuC1QIotZGNfjNBgpQx+hh3z3hUvDxb
ARC-Seal: i=1; a=rsa-sha256; t=1521941602; cv=none;
        d=google.com; s=arc-20160816;
        b=G0jHYg8CTWz4jyZQxwHEvZZpFHymwGS45rIJnSBEIQoqz07tuaADUGAC7GYt/LeSw0
         /HO9cA8S7+rEJGrYHkDWBuqCVlhfc5lWQ0y0GOduRYI4Z2GByb9Gb8Q6x8dQmkLIYGoz
         2XCM5207+kztBmgAUDE/JL76x+SMYalg0lxMDqdMtVN68hK3XTFGJ2+3gExOHALNYKu9
         erxnP67JOfHL9WYFjyz07McXn2GZplyJD6PZgThmbD3wX4GYBqHLpyYsGFCt2IlAW6UM
         yMqNE1mWVJ2K4Jas4Jb419KaMmyGOH3hJfZLNTFuGZNWPDwb8Cnfgzu2u880h1Das/AF
         c/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=upWrBCHIV0xmQrs2oxOwd21m6GhYe3GmeD21AgjJvOQ=;
        b=nCBgRMxGz5FWO122NyLl1yxAjsYhD0LFIrUtsOWGDNVQZfDGfPak8xPLkGBEiyrNEm
         HIiSmi5YYQH1I3xp+xDD1W9GvLy7LTDj9CqcGbMOEY4aeY9duQYAHXyuaplYNfKtQnxF
         trJaaeYspKyP3S35p3CwdVi8jZRbuOre8O5qNnDiyMxLi/gZ+PdqLwPyhHD6e4gb+zQ2
         rTZPpaK3q7eQimxf8VU1N1c1A9xISZKNW13OHn0D+ovqv7fA58i9ZBHEK072bP6ENxrW
         kzbdro5dYLKC3JcdqIQSpZNGYSVpf0++iVtv6e+Q/KZWFufWVOHS45yi89BKhhFzQ2o/
         IZYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12727-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12727-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12727-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12727-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 6/8] Pmalloc selftest
To: Matthew Wilcox <willy@infradead.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-7-igor.stoppa@huawei.com>
 <20180314122512.GF29631@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <ce6e34a4-592d-624c-2353-20e50e321298@huawei.com>
Date: Sun, 25 Mar 2018 04:32:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314122512.GF29631@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860941197895401?=
X-GMAIL-MSGID: =?utf-8?q?1595871437425815485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 14/03/18 14:25, Matthew Wilcox wrote:
> On Tue, Mar 13, 2018 at 11:45:52PM +0200, Igor Stoppa wrote:
>> Add basic self-test functionality for pmalloc.
> 
> Here're some additional tests for your test-suite:
> 
> 	for (i = 1; i; i *= 2)
> 		pzalloc(pool, i - 1, GFP_KERNEL);
> 

Ok, I have almost finished the rewrite.
I still have to address this comment.

When I run the test, eventually the system runs out of memory, it keeps
getting allocation errors from vmalloc, until i finally overflows and
becomes 0.

Am I supposed to do something about it?
If pmalloc receives a request that the vmalloc backend cannot satisfy, I
would prefer that vmalloc itself produces the warning and pmalloc
returns NULL.

This doesn't look like a test case that one can leave always enabled in
a build, but maybe I'm missing the point.

--
igor
