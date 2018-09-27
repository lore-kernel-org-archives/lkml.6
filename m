Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31C3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8B52170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BDkl75S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8B52170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeI1AaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:30:12 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:33564 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1AaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:30:11 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20180927181042usoutp02731745b764382538ae50a421e8af3543~YVDD9tfzP1090210902usoutp02K;
        Thu, 27 Sep 2018 18:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20180927181042usoutp02731745b764382538ae50a421e8af3543~YVDD9tfzP1090210902usoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538071842;
        bh=u9tiJpivyknNghoVGyj6Pbp6EttodY+AuJ8r9sBIL34=;
        h=Reply-To:Subject:To:CC:From:Date:In-Reply-To:References:From;
        b=BDkl75S08eGi9SN33i4dyO55Iu28+fs+CDh8dggAWW+0YAtXZVSepPEwAOY/v7fae
         jITzQbO5vsOGBgTmMc+Z5XFa7wnbo5L+IHrupf2odruFdo/Fwl7LRWzKOb8oPxJLyW
         +pJAYHhZ6iuA5V81Hs6Dk74DRUW6gmcxJAAqD/sw=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180927181041uscas1p2d34686c57a0d1da832aa5771ec5c712e~YVDDycGus2204922049uscas1p2Y;
        Thu, 27 Sep 2018 18:10:41 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 3B.2F.04445.12D1DAB5; Thu,
        27 Sep 2018 14:10:41 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180927181041uscas1p18c054816d2dba808caef072b3fdf3a7d~YVDDancH71228012280uscas1p18;
        Thu, 27 Sep 2018 18:10:41 +0000 (GMT)
X-AuditID: cbfec36f-c8bff7000000115d-25-5bad1d2160dc
Received: from srafidmail01pr.sisa.samsung.com ( [105.144.21.50]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 01.57.04524.12D1DAB5; Thu,
        27 Sep 2018 14:10:41 -0400 (EDT)
Received: from sisasmtp.sisa.samsung.com (sraex01sc.sisa.samsung.com
        [105.160.16.22]) by srafidmail01pr.sisa.samsung.com (Postfix) with ESMTP id
        CE2B74C0C04; Thu, 27 Sep 2018 18:10:40 +0000 (UTC)
Received: from [105.160.10.158] (105.160.10.158) by
        sraex01sc.sisa.samsung.com (105.160.16.22) with Microsoft SMTP Server (TLS)
        id 15.0.1367.3; Thu, 27 Sep 2018 11:10:39 -0700
Reply-To: <shuah.kh@samsung.com>
Subject: Re: [PATCH] rseq/selftests: fix parametrized test with -fpie
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        stable <stable@vger.kernel.org>, shuah <shuah@kernel.org>
From:   Shuah Khan <shuah.kh@samsung.com>
Message-ID: <2bfea3f5-b251-d4b8-d03a-28b575aefae0@samsung.com>
Date:   Thu, 27 Sep 2018 12:10:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <44897232.11546.1538071328396.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [105.160.10.158]
X-ClientProxiedBy: sracas01sc.sisa.samsung.com (105.144.22.46) To
        sraex01sc.sisa.samsung.com (105.160.16.22)
X-Content-Scanned: Fidelis Mail
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+69vffS2XmsmL4DFtxN3KLL0BmznEwxmuhykmXJMv9wKSGz
        yh04oWivdQOXDVdUhgg66YDKRrcJfpUZWz6KLJVUvqYMorCBqFtHGEFaVMYcA3XOy60Z//3e
        8zxvzvMkr8ga2/g4cbt1t2yzWjIlXs81tN/vfuWF52tTVlwaWEEqz3l40vrLlEBKbtYwxFO3
        jyF3a4oQ6f87gkhzOMCRL8+byHSfRB67s4lvqoAnvRcqeVJ28y5PbvQayNnaPB3x/dTFkmst
        boZcPhISyLhvSkc6DrcwpOn0KR0JFIQYUnr7e4E4/7rHEff5IUR8XidLhorHBXJ7opNbl0B/
        izziqOdrD6L5jiKeVl+J8PSo445Aq5omEG1y3RJofmBQoG6vnfpOLaOD4WTqPfM5T+90dwu0
        s/wBR4f7yhgaCvq4t2PN+jVpcub2PbJt+dot+oxDxyfYncfnfxQemBHyUOG8QhQjAl4FkekO
        vhDpRSM+jcBbXsVqw34Gir5rY5+6QiMNUVc9gm/7fogOHQgeFD9kVJcR+xD8WWPQeDHcb1c3
        YsSFeCP4y/JnORa/Bl98Njn7BYuPiVA+MMOpAo9fgsmwX1DZgNdCsLJTpzKHl0D/6I3Z90X4
        XWgNfYM0zwL4sWL4ya4oxmAK9Y6tKrJ4KZy7sFx1sNgEg8NVjMaJ0DheGS0jwdiYA2lshf1d
        bk7jRBg928io0QCHRKi62MVowgYYq26P8kIY66gTNI6Hn/udrLZwEMFXJyqiQimCe9WxGq+G
        xy09gpbiWXg0M4TUoIANUHDAeARJrjltXP9XcM2p4JpTwY24M8hkV5SsdFlZaZU/TFIsWYrd
        mp60LTvLi54c95V/L2X7Uc+JbUGERSTNM2wZ8qQYdZY9Sk5WEIHISrGGF+NqU4yGNEtOrmzL
        fs9mz5SVIIoXOclkuNx8KMWI0y275R2yvFO2PVUZMSYuDy1eFGlbWv6xrfaYdNLvzDX79+b4
        N2SsNx0c2HUxqczm6LUkhHddxcnh+T1pS1buTX6uvlq/qR5vXPD6+pLUkrdG9/1+NCFxjbOp
        MfWPTc321b+2vj+RMRL/cqBOnk4NpE1OfXL9HXPFM29+urlxxGxs2Hr91hvmVYcPFOwojdOf
        LP4n9wOJUzIsry5jbYrlP3zp/XDYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/0993Dzc3r4rrL0s5isJ4t9mRoz23czw8yW2tTht2rqaver
        FGrpGkkoRTo3boaii7mLLiY5D12izcM89KCTQ3U9qJA04rqh/16fz/vzfn/22T4cKb9D+3BJ
        ynRRpVQkC4wrlVTiuSQ4YG5tbNjtMoi0V/UMuv9ynEXHOi8SSF+3n0DDF4sBevVtAKBb9kYK
        nbzmjSZeCGhKl4qM44UMen5Ty6CKzmEGdTyXoZraPBoZnzwm0bMmHYEelVhZNGgcp1HzkSYC
        NVyqplFjoZVA5X1XWHTiy2cK6a71AGQ0nCBRz9FBFvWNWKhVfrh74CeF9Wf0ABeoixl8oXWA
        waXqIRafbRgBuEHTxeKCxnYW6wwZ2FgdhNvtkdhw+RCDh9raWGw5NUlh24sKAlvNRmqjR4zr
        yp1iclKmqAqNindNPHx6hEw7PSvL/voHmweK3IuACwf5CGj9eIMpAq6cnDcCWHDewDqLZgC1
        1nLwTzlf1806LHJ+Hvz60GFx4ebwa6GpomCaPfhl8Hj+GOlgki/l4JsD8U7zdwJOtuooh8Dw
        C+GY3TQdJOOjoFlroR1M8YHwVW/HdN+Tj4Y1Vb20c2Y2bKm0/fFynAuP4XX1dgeS/CJ49Wao
        c5U3bLedJZzsD+sHtaTzMgH296uBk5Xw6PAo5WR/2FtTT5QAT82MBZr/qZoZqZoZqTpAXQbe
        GZKUkpAlhSvF3SGSIkXKUCaE7EhNMYA/b9X6695WE7C07jADngOCu8xk08fKaUWmlJ1iBpAj
        BQ/ZAp/aWLlspyJ7j6hKjVNlJIuSGfhylOAtq/LSxcj5BEW6uEsU00TVX5XgXHzyAO0eJ4SO
        rvaTyjLdbsncqPf6Ty3vrNvWXVFv2VrvEdyx/i4hV0f0587b0D3Xzd1iMh2Ujedk//KqOpQ/
        FeB1xr5mQ1DH8o1vH4RaSsFebNmXoDzWRC+Gm8OKm29v9+zbtLTsaa6worJi6INvVHLPkWfc
        WGTOuU7bRFd04Lma+TlxAiUlKsKDSJWk+A2dTpbIUgMAAA==
X-CMS-MailID: 20180927181041uscas1p18c054816d2dba808caef072b3fdf3a7d
X-Msg-Generator: CA
CMS-TYPE: 301P
X-CMS-RootMailID: 20180927132250epcas4p3d0775cc258f6112d27bdad359fc6e416
References: <20180918135328.32034-1-mathieu.desnoyers@efficios.com>
        <1367962117.10271.1537897176578.JavaMail.zimbra@efficios.com>
        <CGME20180927132250epcas4p3d0775cc258f6112d27bdad359fc6e416@epcas4p3.samsung.com>
        <20180927092235.77282e35@vmware.local.home>
        <a7bae2ff-1f4d-dbfc-43f8-e7a89f319abb@samsung.com>
        <44897232.11546.1538071328396.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 12:02 PM, Mathieu Desnoyers wrote:
> ----- On Sep 27, 2018, at 9:58 AM, Shuah Khan shuah.kh@samsung.com wrote:
> 
>> On 09/27/2018 07:22 AM, Steven Rostedt wrote:
>>> On Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>
>>>> ----- On Sep 18, 2018, at 9:53 AM, Mathieu Desnoyers
>>>> mathieu.desnoyers@efficios.com wrote:
>>>>
>>>>> On x86-64, the parametrized selftest code for rseq crashes with a
>>>>> segmentation fault when compiled with -fpie. This happens when the
>>>>> param_test binary is loaded at an address beyond 32-bit on x86-64.
>>>>>
>>>>> The issue is caused by use of a 32-bit register to hold the address
>>>>> of the loop counter variable.
>>>>>
>>>>> Fix this by using a 64-bit register to calculate the address of the
>>>>> loop counter variables as an offset from rip.
>>>>
>>>> Should this fix go through tip or the selftests tree ?
>>>>
>>>
>>> I usually have changes like this pulled through Shuah's tree with an
>>> ack from the maintainer of the code that it tests.
>>>
>>> -- Steve
>>>
>>
>> Right that is what I prefer. I usually wait for an Ack. I can pull this
>> in.
> 
> I am maintainer of the code that it tests as well, so being both author
> of the selftest patch and giving an ack to it seems a bit silly. :) Other
> rseq co-maintainers could weight in though: Peter, Paul, and Boqun.
> 

I was commenting in general, not specific to this patch. No worries. I will
apply this right away.

I have been traveling the last couple of weeks and in the catch up mode still.

thanks,
-- Shuah


>>
>> --
>> Shuah Khan
>> Sr. Linux Kernel Developer
>> Open Source Innovation Group
>> Samsung Research America(Silicon Valley)
>> shuah.kh@samsung.com
> 


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com
