Return-Path: <rogerq@ti.com>
X-Google-Smtp-Source: AG47ELthqr8xnk5CdtEnFET6v/BHASa3XCO9PJYk0v9yQ3x8Joxjlq1ODeWTxd0wk8fFGjFM5fC8
ARC-Seal: i=1; a=rsa-sha256; t=1520585648; cv=none;
        d=google.com; s=arc-20160816;
        b=TlaHTPIiOtWG2t07/j+iRjUSUFYM6GS2d3bV13J7lLQwH4ytEVZ1B6SL44NeIpx8Et
         aZpvjmDDQn6bjwCX9R5naqjHl3w/7HBRwQXQAfHZX5D7JjpX5Uux3nbEgQHezi+MjonB
         zleAsQYFozkyYZfrpilFCTvDajCIm8FLmExdNE/mE3wS0y4WqSp/WwhyYMdmApATwkx5
         DFNVVUcX3s46T8QM2vCpS60xforbOGndBhobRpcUu9GPy8zRKD4qLGkOk+6glGCbUQ6A
         vXzq6f8+9eTAtaaAY+AW6J5wMct69qtjB928tSEzjV8C9Jc/uX6OqyFoF8t4IZK9HLKf
         mlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=z6LRrj1kEYBx1L9MBJuBZQVzaur7A3D0iH9HbU8ZRQA=;
        b=PmwHv0rBzaxarRRoMIlxZ+MCbFkxsq7uoWFeo993NWXL4Zh4GFadRW/jOOYxTGXwlR
         fFIuYuZowJTKID8r1QpPA9rMCmeb4sg+JaaG4fzaPMNlcwIHbPsBwIK/TGsGdp4cioFJ
         f3+lZCMK/Ay4J8sW1t5XvgPtPBQBNTyEwoy7zfg4w4ymKky4dgtMMO9/CGSmsW34AeUn
         U/xI0IhHKyCgbfBCyazjJXd0I0GuMk70qgLIic5u8Qjxj7VnWDNDH9xM17Hp0R7Nmo9x
         c2NWby8qHtgV1NfZ5vHFYm6uDbCVW/LVRiTAUuBBCjMO3g8gKpLs9wnHUT8X/cZkpmK4
         B99Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=m26eIQsL;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=m26eIQsL;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH] usb: dwc3: core: power on PHYs before initializing core
To: Brian Norris <briannorris@chromium.org>, Felipe Balbi <balbi@kernel.org>
CC: William Wu <william.wu@rock-chips.com>, <gregkh@linuxfoundation.org>,
        <heiko@sntech.de>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <frank.wang@rock-chips.com>, <huangtao@rock-chips.com>,
        <dianders@google.com>, <briannorris@google.com>, <groeck@google.com>,
        <daniel.meng@rock-chips.com>, <John.Youn@synopsys.com>,
        <lin.huang@rock-chips.com>
References: <1515729616-8639-1-git-send-email-william.wu@rock-chips.com>
 <87ina6vodf.fsf@linux.intel.com>
 <20180308164916.GA65031@rodete-desktop-imager.corp.google.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <abca45d6-2304-a607-5185-f26327a653f5@ti.com>
Date: Fri, 9 Mar 2018 10:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308164916.GA65031@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589357732274674960?=
X-GMAIL-MSGID: =?utf-8?q?1594449617302494479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 08/03/18 18:49, Brian Norris wrote:
> Hi,
> 
> On Thu, Mar 08, 2018 at 12:43:40PM +0200, Felipe Balbi wrote:
>> William Wu <william.wu@rock-chips.com> writes:
>>> The dwc3_core_init() gets the PHYs and initializes the PHYs with
>>> the usb_phy_init() and phy_init() functions before initializing
>>> core, and power on the PHYs after core initialization is done.
>>>
>>> However, some platforms (e.g. Rockchip RK3399 DWC3 with Type-C
>>> USB3 PHY), it needs to do some special operation while power on
>>> the Type-C PHY before initializing DWC3 core. It's because that
>>> the RK3399 Type-C PHY requires to hold the DWC3 controller in
>>> reset state to keep the PIPE power state in P2 while configuring
>>> the Type-C PHY, otherwise, it may cause waiting for the PIPE ready
>>> timeout. In this case, if we power on the PHYs after the DWC3 core
>>> initialization is done, the core will be reset to uninitialized
>>> state after power on the PHYs.
>>>
>>> Fix this by powering on the PHYs before initializing core. And
>>> because the GUID register may also be reset in this case, so we
>>> need to configure the GUID register after powering on the PHYs.
>>>
>>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>>
>> does this cause any regressions for your boards?
> 
> I'm not Roger, but I believe it was determined we don't need this for
> the Rockchip systems for which William was originally sending this. At
> least not right now. I believe our PHY init problems were mostly
> resolved in other ways.
> 
> (Although I hear USB is currently pretty broken around suspend/resume
> for us on -next. Likely unrelated.)
> 
> I guess we never clearly replied stating the above. I hope this isn't
> merged anywhere? Or I guess it's no problem to me at the moment, but it
> might be needless churn.
> 

I did some quick tests on TI platforms and didn't see any issues with this patch.
Since this patch isn't really fixing your problem and we didn't have any
problems to start with I'd suggest to avoid this churn for now.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
