Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF71AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741A1214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j4vESkXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741A1214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbeHPKNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:13:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53616 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbeHPKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:13:40 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7G7GqPc034929;
        Thu, 16 Aug 2018 02:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534403812;
        bh=Xg6Y6bTu0cftcPUEwsx/XZR7EOp31qF1a0Nq+eGg07s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=j4vESkXq3E9U0aaOW6ZrbqqZIMLLY8yloQnEPL6BQHgJh5DLkosLuYWcGvhxKQKEt
         aOEwJfdEHGfdF4zL6hPx2m5q8/tejWBsfw2CocNx44Cp4vAkScqMmYgiZAtKMcghqB
         ZWpEuoxdofAO505hrHjYUDdlUXumxN9ZLGf1N7mk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7G7GqL4011451;
        Thu, 16 Aug 2018 02:16:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 16
 Aug 2018 02:16:51 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 16 Aug 2018 02:16:51 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7G7Gmad021125;
        Thu, 16 Aug 2018 02:16:49 -0500
Subject: Re: [PATCH] usb: hub: try old enumeration scheme first for high speed
 devices
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "joe@perches.com" <joe@perches.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <678F3D1BB717D949B966B68EAEB446ED0C9B12B9@dggemm526-mbx.china.huawei.com>
 <Pine.LNX.4.44L0.1808141022450.1466-100000@iolanthe.rowland.org>
 <678F3D1BB717D949B966B68EAEB446ED0C9B2CC0@dggemm526-mbx.china.huawei.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 xsFNBFT1lPYBEADZlKgOS2lxNkDRlcROza/QPsYrS+V2YAXOd4rO/sshQDt1OgU4E8DD37t0
 F4zipBkMVU1nQ6ZSomg2o9w17wD7sL0wNO+QZ0j5V2yy2SJIlK70lgmz90GlL93V3T/BFJNr
 YdtC6FBWvczrXXz6qIKq+3s9j+gMx4CFsZX8vq35xcsaNdyWzX2J7hqMKQ+vYuLvy3u2UMIc
 pgkwfx5CHXHmWVr4/qWPB+O9YtN9m1ezfPLwbZ73Ea5LpnvCGO6s4IHFLl2hPpDGUCHHV/1N
 qg3N5ztm4bhN9C0+1qdmhuFGhkfC3O4h/ncywTUNuxqk2Tux19GX3BeWiJF7QVVJb2iXttdo
 Zi44vp32I7LbcMcXYifHHGYwS5GeAudx6O19RTS+D7XQ1BkSmw8weaTleLhJwApVBon2KziB
 NscqXsj6CdKFwLFsDPkkvYCsEpWz3C9UUn8veOna2STk8oyk1GM+iVarBad6gs0n8NFNrR2n
 nLjIFuZ6GIwec3HNaX5Zk3ap1z7qsZ/BVou8r95FJw7cAQU3H5vgHZkGHy9xl6LmPvAf0tWT
 sO1a9mbf7gcC2u4ccHJ+hTvGk62/E/+AxbtzUDQI0D2ouS9DnwO92UZDJrJhj6m3u1c8mR45
 W2CFvZSVPmDSxbyWm3ADzsjfRQlhLkzsV9BoDq8uRMzWUPd8IQARAQABzTRSb2dlciBRdWFk
 cm9zIChLZXkgZm9yIExpbnV4IGtlcm5lbCkgPHJvZ2VycUB0aS5jb20+wsF4BBMBAgAiBQJU
 9ZT2AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDSWmvTvnYwkwP2EACuDMmuKaYm
 rcMhjVcvrrWF7n1LGI4nrmVH93fAI8wZsLSpUwyHeLGNTwSOvJC6U4qLvJAejttdW/DCvU+8
 cETqkeh36IQhvxNdp6HGXPD+hywZiDHZi54mfpLU7DTExGyuyKKbh7leH/5QvhZF/NkEXHIC
 g9caDvnmg0CI5VI6QsleiQPNFL7VYZ3neGKJRHjUGTbKPc/9InqzTCWH7ZI3W0aZoAFrOOYv
 4bWSohSruEEYKwE6ebvflwESOj5ikVJY5cPmscYfR6LIBzXtTL4fg296sqkeNtvU99DMjKGX
 LTKmxPY5lnPkDY1YJbAJKoQ+8DYB5GnXA3CNscgXDQGIwbq2eKlGgLhMjyDVmjGHB0FOuuFQ
 6W+PLP0FfYqQdQwJWbPfvXoku3IlljwxAN+gvzi0xD3Yqpl3VDjbn2n/2aRuqa8pVVCrsUnG
 4LeoDJeMIHyddK61HXDhN0SoA4RNLm6ZW8E+2DH8ZbFbw8IkSyh9Op01LMzD9tr47JRcrGgv
 K4o1QOwSe1NIK7yQ/SrENiMvICTeAq4gqvc/maDWbylNsYZc3VO9VAhCCghbdk7kRfYWhzBg
 C/2RgkMGBBTAOVgMbPcDpFzD5Dukg+Jy4xn97bA/MSH8CyYcLZos0SaSzrjNVIvm+TN71k9+
 Q2EhsrlhWj64+IjYmzVIFHyTmc7BTQRU9ZT2ARAA16PDhYuCNxXwcXAPlgpVIXC5ZxvB3xWK
 QifhimnqxvJsCNkNWt8I3jfY+GwjsjTldzA4jIbHTuaHhXgMMu9YoUVK/YBp5IZ/NiQ3yVL5
 K5XU0q/BtG30yox9CPjWCA7OmT3mF+1vT9UrEEPCs8KpWER5ajk+rQpTc1WuwJqBB5WeIlZJ
 odjxuL3r1Zpgk7LxPwwaw15WutKPFY8ClvXqlmmkU4zlCC5s4oR39f6E6B31yun621fvgu8X
 LFY4i7aUkVYUleKd7L/GAV98Dnbrop48bQM+gDtyPODPh8fJylsPvZAYEqiapSsYiHvts3r/
 nEw0RASNyjp5pNBWb5/JbBjboKhGCoBJzkDHcr5VbeOXuemymJHqgysbmDZY415olIOrYQGT
 b9p/zg5U/eGFsxKnAe4LquX9oAoEu6K/zkUbA/1LEjSTxu3xGCczxe2ZsKthdYztDkntsw+t
 U9bt2DCXhmabMCcYS1YP72ZVITpLk4qRfxcrtzgx/uGfuMZDuN7JVYqCz7AI+xEQBLlQWXhL
 cJ8dH0d+H/3Zs9LVaJAqoc9CiYo1yz8NUH+yHGxz437ccUic8HPB2lIiL/W6C4wVhUbm2w9F
 4VdByWgWCCY5Ynhe188sqNL+mFqLAaIssqyYwTBJM+Go6tOuRnP6jrkf2Va/pIwIltzf9QOW
 cgEAEQEAAcLBXwQYAQIACQUCVPWU9gIbDAAKCRDSWmvTvnYwk8niEACcwBAfe1tTSqCCHkRj
 zgIrt+NPBBfxilf9JXPGTYqfUkrcVfiNqLGFgIDZKjkLfArxiSmpmtKf1O1VYO9XDgADUKJO
 RvmUQM/l3Q99QC5b8yUyZOsgfSBOsV6DeqiULO30cXH/uEpR2fUcbtyYXHouiF2UNdq/BV5h
 HBQkGYtTf7K26NPp4wXMS+YsBm2Gbms/wywJh4KgRPP6LuA+UE/7l0xqMD3pBQ/L1KLTqOQY
 CItcZ0YbEvlrJc25PRkCssHf1J2c2MXV+CRqsibW8UamBmOyzKHVK/CwvIndwBmcciJrOf+4
 uxegvXEnwvYPuQ3wvBSkgbJRFNJemnp5KSczANr4R/aA5cEbxhbg7peLv0FdFyTFJXCsKeuO
 1gKoKtOLyxRhDocprSuEamaDWDCy3TmX+6nWaBIPYXDFT7IcHT6l6TyZ6IMjkXiHSLhynTIj
 f2xjSrvKPljIUxcqjhyqWe+coe/Xwbqz69DsK150xoAaoS3rbNlhmalbg15HNTipNDI/k81A
 fwt7ncjxvjXVJnA2nqPBDIW3mZO/ED0blLrVdaMZjf5LvS+vvsMdH7dHtrAXA50egr74sX0A
 NO7iW+gkmFYwap531ipMXthHPWbo5x9xfb+a48xA80ePBJLBDyw9X+cOe40+N4Ybiwy5Q2La
 IwrfNkJOLj3CvocMIw==
Message-ID: <f4372b12-327c-ee51-76ae-2e2bc5cdceed@ti.com>
Date:   Thu, 16 Aug 2018 10:16:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0C9B2CC0@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/18 09:21, Zengtao (B) wrote:
> Hi alan:
> 
>> -----Original Message-----
>> From: Alan Stern [mailto:stern@rowland.harvard.edu]
>> Sent: Tuesday, August 14, 2018 10:40 PM
>> To: Zengtao (B) <prime.zeng@hisilicon.com>
>> Cc: Roger Quadros <rogerq@ti.com>; gregkh@linuxfoundation.org;
>> mathias.nyman@linux.intel.com; drinkcat@chromium.org;
>> felipe.balbi@linux.intel.com; drake@endlessm.com; mike.looijmans@topic.nl;
>> joe@perches.com; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: RE: [PATCH] usb: hub: try old enumeration scheme first for high speed
>> devices
>>
>> On Tue, 14 Aug 2018, Zengtao (B) wrote:
>>
>>> Hi alan:
>>>
>>>> -----Original Message-----
>>>> From: linux-usb-owner@vger.kernel.org
>>>> [mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Alan Stern
>>>> Sent: Friday, August 10, 2018 10:20 PM
>>>> To: Roger Quadros <rogerq@ti.com>
>>>> Cc: Zengtao (B) <prime.zeng@hisilicon.com>;
>>>> gregkh@linuxfoundation.org; mathias.nyman@linux.intel.com;
>>>> drinkcat@chromium.org; felipe.balbi@linux.intel.com;
>>>> drake@endlessm.com; mike.looijmans@topic.nl; joe@perches.com;
>>>> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] usb: hub: try old enumeration scheme first for
>>>> high speed devices
>>>>
>>>> On Fri, 10 Aug 2018, Roger Quadros wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On 10/08/18 18:01, Zeng Tao wrote:
>>>>>> The new scheme is required just to support legacy low and
>>>>>> full-speed devices. For high speed devices, it will slower the enumeration
>> speed.
>>>>>> So in this patch we try the "old" enumeration scheme first for
>>>>>> high speed devices.
>>>>>
>>>>> How slow does it get? Is it significant?
>>>>> Do we risk breaking existing HS devices that work? I don't think we
>>>>> can be sure till we run this through testing.
>>>>
>>>> Indeed.  I am extremely skeptical about a patch like this, unless
>>>> somebody can show that Windows uses the "old" scheme for high-speed
>> devices.
>>>
>>> Yes, this is what the windows has done, you can refer to
>>> https://blogs.msdn.microsoft.com/usbcoreblog/2013/04/11/usb-2-1-2-0-1-
>>> 1-device-enumeration-changes-in-windows-8/
>>
>> And that blog post is 5 years old!
>>
>> Okay, I think we can go ahead and make this change.  However, you should
>> update the patch description to mention what Microsoft did in Windows 8 and
>> say that the new behavior matches theirs.
>>
> Okay, I will update it the change log in v2.
> 
>> Also, as Roger mentioned, you should update the documentation to say that the
>> old_scheme_first module parameter now applies only to low- and full-speed
>> devices, since high- and SuperSpeed devices always use the old scheme first.
>>
> 
> Since we should have dedicated enumeration flow for SS, HIGH, low and full speed devices,
> So I think the old_scheme_first and use_both_schemes parameters should be removed.
> What do you think about it?

I think we should retain them as some host controllers can have issues
and these parameters give some control to system integrators to workaround if required.

I'm aware of one errata [1] that requires the old_scheme_first to be set in certain
circumstances.

[1] http://www.ti.com/lit/er/sprz429l/sprz429l.pdf
Section i897

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
