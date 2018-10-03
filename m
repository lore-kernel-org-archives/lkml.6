Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DCBC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CE12098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CE12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJCO0N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:26:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56184 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeJCO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:26:13 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g7bkJ-0008J1-Qb
        for linux-kernel@vger.kernel.org; Wed, 03 Oct 2018 07:38:59 +0000
Received: by mail-pf1-f200.google.com with SMTP id n17-v6so2282980pff.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yh/6ncW9ETWEeL7pLFudjKgnwFCrlPUQF3iVzgkVGtU=;
        b=lX57GRa3tz46HCw1ODKW09lczkH8cQK62vx6fQ9rBR8j9n6/9C+LIMcJIWlt5Sowww
         NAY0/wzuC8c+OjFmMPjof69FvMOCHd7zoQJa/0lWZlIZDCtxRNzhWF611i0sqy88JLvX
         KAZ76x2IVhoKPQ26yEPhahmQbVosDnasNPETy0K9HgDSEknuMXTN1FSlDhxhI1Ln1I0j
         BwXPZMmH2VcTaRuoTeAvRFy/1TZ1YGnSHGHWwR/Sycj62v+uIBLw7TUCo1hR5hbbQVFW
         SiR/jDo2D4wKnxXd+arhXtdxHu556L7ell0HaWPDEt/TrlkWNXYst7BdKBfyLy7SnLDt
         Od5A==
X-Gm-Message-State: ABuFfojvMDBe+/XjKreOmRTQPZjefHDXm6gaLVhI9yqyXaWJEua1YdFs
        s1Ybf8gDId+zRzKv/n+MA/Pujczc3BgZWKXTT4g770RjFCFnxxCE6NKXF/4rqlyTeKvIcrz1cA/
        bR6yWbkR98tQ6Y6bX7Z6oiDvIwAPPPbb18xIx1e8fLQ==
X-Received: by 2002:a63:80c6:: with SMTP id j189-v6mr236641pgd.40.1538552338413;
        Wed, 03 Oct 2018 00:38:58 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61sGIkVSYJBGEvLHhZlnp77b4bIdQHyXPWpp8+N3ra9uc2pGnsngFhG3sSX9G+z0dLCoAZ8Yw==
X-Received: by 2002:a63:80c6:: with SMTP id j189-v6mr236619pgd.40.1538552338137;
        Wed, 03 Oct 2018 00:38:58 -0700 (PDT)
Received: from [10.101.46.95] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id p18-v6sm688022pgi.5.2018.10.03.00.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 00:38:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 3/3] iwlwifi: Load firmware exclusively for Intel WiFi
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CALx5=V_0fyTcpTdYh=ZOLWL79cop1F=5GyMuK6S9QnP5qHKouQ@mail.gmail.com>
Date:   Wed, 3 Oct 2018 15:38:53 +0800
Cc:     Luciano Coelho <luciano.coelho@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, johannes.berg@intel.com,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        linuxwifi@intel.com, Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <24BAAAAB-17E4-4820-A09A-50984B8EBA40@canonical.com>
References: <20181003071513.13004-3-kai.heng.feng@canonical.com>
 <2787bccf20b6f647de9f4cafae5fd223e771b167.camel@intel.com>
 <81B978A9-270E-4C0B-BE67-D05899B1BC3B@canonical.com>
 <CALx5=V_0fyTcpTdYh=ZOLWL79cop1F=5GyMuK6S9QnP5qHKouQ@mail.gmail.com>
To:     Matt Chen <mattsled@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2018, at 3:29 PM, Matt Chen <mattsled@gmail.com> wrote:
> 
> I think Canonical were facing some wifi fw load error from some 8260
> earlier module during the BT still loading the fw.
> I believe we had later 8260 sku that fixed this issue.

But there are already 8260 that is affected by this bug in the wild.

Search "Bluetooth: hci0: Failed to send firmware data (-38)” and there are lots of user are affected.

Kai-Heng

> 
> Hi Kai-Heng,
> 
> Can you check with OEM for which SKU they are reporting the issue ?
> Kai Heng Feng <kai.heng.feng@canonical.com> 於 2018年10月3日 週三 下午3:28寫道：
>> 
>> 
>> 
>>> On Oct 3, 2018, at 3:24 PM, Luciano Coelho <luciano.coelho@intel.com> wrote:
>>> 
>>> On Wed, 2018-10-03 at 15:15 +0800, Kai-Heng Feng wrote:
>>>> To avoid the firmware loading race between Bluetooth and WiFi on Intel
>>>> 8260, load firmware exclusively when BT_INTEL is enabled.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>> 
>>> Where is this coming from? Can you explain what "the firmware loading
>>> race" is?
>> 
>> Looks like the patch is not correctly threaded. I’ll resend the series.
>> 
>>> 
>>> 
>>>> .../net/wireless/intel/iwlwifi/pcie/trans.c   | 37 ++++++++++++++++++-
>>>> 1 file changed, 36 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
>>>> index cc8c53dc0ab6..c30d3989e2a8 100644
>>>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
>>>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
>>>> @@ -71,6 +71,7 @@
>>>> #include <linux/vmalloc.h>
>>>> #include <linux/pm_runtime.h>
>>>> #include <linux/module.h>
>>>> +#include <linux/intel-wifi-bt.h>
>>> 
>>> I don't see this upstream.  Is it something that was recently added?
>>> Looks odd...
>>> 
>>> Regardless, this should also be protected on CONFIG_BT_INTEL.
>> 
>> Thanks, I’ll update this one.
>> 
>>> 
>>> 
>>>> #include "iwl-drv.h"
>>>> #include "iwl-trans.h"
>>>> @@ -1335,6 +1336,10 @@ static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
>>>>     bool hw_rfkill;
>>>>     int ret;
>>>> 
>>>> +#if IS_ENABLED(CONFIG_BT_INTEL)
>>>> +    void (*firmware_lock_func)(void);
>>>> +    void (*firmware_unlock_func)(void);
>>>> +#endif
>>>>     /* This may fail if AMT took ownership of the device */
>>>>     if (iwl_pcie_prepare_card_hw(trans)) {
>>>>             IWL_WARN(trans, "Exit HW not ready\n");
>>>> @@ -1394,6 +1399,7 @@ static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
>>>>      * RF-Kill switch is toggled, we will find out after having loaded
>>>>      * the firmware and return the proper value to the caller.
>>>>      */
>>>> +
>>> 
>>> Stray empty line.
>>> 
>>>>     iwl_enable_fw_load_int(trans);
>>>> 
>>>>     /* really make sure rfkill handshake bits are cleared */
>>>> @@ -1401,8 +1407,37 @@ static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
>>>>     iwl_write32(trans, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
>>>> 
>>>>     /* Load the given image to the HW */
>>>> -    if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000)
>>>> +    if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000) {
>>>> +#if IS_ENABLED(CONFIG_BT_INTEL)
>>>> +            firmware_lock_func = symbol_request(btintel_firmware_lock);
>>>> +            firmware_unlock_func = symbol_request(btintel_firmware_unlock);
>>>> +            if (!firmware_lock_func || !firmware_unlock_func) {
>>>> +                    if (firmware_lock_func) {
>>>> +                            symbol_put(btintel_firmware_lock);
>>>> +                            firmware_lock_func = NULL;
>>>> +                    }
>>>> +
>>>> +                    if (firmware_unlock_func) {
>>>> +                            symbol_put(btintel_firmware_unlock);
>>>> +                            firmware_unlock_func = NULL;
>>>> +                    }
>>>> +            }
>>>> +
>>>> +            if (firmware_lock_func)
>>>> +                    firmware_lock_func();
>>>> +#endif
>>>>             ret = iwl_pcie_load_given_ucode_8000(trans, fw);
>>>> +
>>>> +#if IS_ENABLED(CONFIG_BT_INTEL)
>>>> +            if (firmware_unlock_func) {
>>>> +                    firmware_unlock_func();
>>>> +                    symbol_put(btintel_firmware_lock);
>>>> +                    firmware_lock_func = NULL;
>>>> +                    symbol_put(btintel_firmware_unlock);
>>>> +                    firmware_unlock_func = NULL;
>>>> +            }
>>>> +#endif
>>>> +    }
>>>>     else
>>>>             ret = iwl_pcie_load_given_ucode(trans, fw);
>>>> 
>>> 
>>> I'm not sure I like adding this BT-specific stuff here, especially not
>>> without a detailed explanation.
>>> 
>>> Did you also send the other patches in this series to linux-wireless? I
>>> can't see them…
>> 
>> I’ll resend one soon.
>> 
>> Thanks!
>> 
>> Kai-Heng
>> 
>>> 
>>> --
>>> Cheers,
>>> Luca.
>> 

