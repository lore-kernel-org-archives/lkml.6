Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756141AbeEAQtH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:49:07 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:41166 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbeEAQtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:49:06 -0400
X-Google-Smtp-Source: AB8JxZrMgtmzb0g2BSjgetiO+HfNwkf3puyUP7EuIHffUY3O8PhwL5fHFzo1vNJGEkcK4qCjgJ5osw==
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode for
 the cells list
To: Alban <albeu@free.fr>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
References: <1521933899-362-1-git-send-email-albeu@free.fr>
 <1521933899-362-2-git-send-email-albeu@free.fr>
 <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
 <20180417165420.423a691b@avionic-0020>
 <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
 <20180417180040.04f53495@avionic-0020> <20180418134119.2e587621@avionic-0020>
 <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
 <20180418143243.3c23493c@avionic-0020>
 <e34619a4-e9b6-9945-a1cc-a3680aac6819@linaro.org>
 <20180418153440.187ed16e@avionic-0020>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d30656d6-f17e-6ed0-251f-2b59d02cd202@linaro.org>
Date: Tue, 1 May 2018 17:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180418153440.187ed16e@avionic-0020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/18 14:34, Alban wrote:
> On Wed, 18 Apr 2018 13:53:56 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
>> On 18/04/18 13:32, Alban wrote:
>>>> I was also suggesting you to use nvmem-cell subnode, but make it a
>>>> proper nvmem provider device, rather than reusing its parent device.
>>>>
>>>> You would end up some thing like this in dt.
>>>>
>>>> flash@0 {
>>>> 	#address-cells = <1>;
>>>> 	#size-cells = <1>;
>>>> 	compatible = "s25sl064a";
>>>> 	reg = <0>;
>>>>
>>>> 	nvmem-cells {
>>>> 		compatible = "mtd-nvmem";
>>>> 		#address-cells = <1>;
>>>> 		#size-cells = <1>;
>>>>
>>>> 		calibration: calib@404 {
>>>> 			reg = <0x404 0x10>;
>>>> 		};
>>>> 	};
>>>> };
>>> But the root cause is in the nvmem binding, this conflict could exists
>> No, the root cause is because of passing wrong device instance to nvmem
>> core. And trying to workaround is the actual issue.
> 
> The data is stored on the MTD, so the nvmem provider is the MTD device.
> I don't think it is a good idea to have a virtual device in the DT to
> accommodate the nvmem API.
> 
Yep, I agree! this is same issue if we make nvmem-cells a child of nvmem 
provider too.

However, I would like to see this moving forward.

I can think of one possible solution here, which is, adding 
"nvmem-mtd-cell" or "nvmem-cell" compatible string to each cell. The 
problem you mentioned regarding #address-cells and #size-cells with 
provider need to be addressed in nvmem core.

Currently nvmem core only support offsets of 32 bits, if you are 
expecting a 64 bit offsets then we should add that as a feature to nvmem 
core.

nvmem core as it is today should work fine with 32 bit offsets for mtd 
cases.

what do you think?

thanks,
srini
