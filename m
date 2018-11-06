Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55335C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7BB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7BB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thorsis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbeKFTaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:30:10 -0500
Received: from mail.thorsis.com ([92.198.35.195]:39838 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387480AbeKFTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:30:10 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2018 14:30:08 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id E5D7D16547
        for <linux-kernel@vger.kernel.org>; Tue,  6 Nov 2018 10:57:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zYr7tTm2pbHG for <linux-kernel@vger.kernel.org>;
        Tue,  6 Nov 2018 10:57:59 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 3808689C6; Tue,  6 Nov 2018 10:57:58 +0100 (CET)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Jean-Michel Hautbois <jhautbois@gmail.com>,
        boris.brezillon@bootlin.com,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sama5d: using the ebi interface from another driver
Date:   Tue, 06 Nov 2018 10:57:11 +0100
Message-ID: <3857132.MlRd14rs7I@ada>
In-Reply-To: <CAL8zT=imudTXvbsxx42mPSQj7Qt1b=44wnPHpb09-sOqLewu-w@mail.gmail.com>
References: <CAL8zT=imudTXvbsxx42mPSQj7Qt1b=44wnPHpb09-sOqLewu-w@mail.gmail.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei hei,

Am Freitag, 2. November 2018, 14:35:26 CET schrieb Jean-Michel Hautbois:
> Then, after looking into deeper details in the datasheet I understand
> it is connected through EBI and it sounds not so easy :D.

Did you read docs on that? You'll find the binding docs here:

Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt

> I would appreciate some help/pointers on this, as there is (at least,
> I could find) few documentation on how to use it except for NAND
> cases.

I use EBI with at91sam9g20 and custom FPGA on CS5 (0x6000000) and CS7 
(0x8000000).

> I have something like that in my DTS, but not sure this is the correct
> way to do it :
> 
>         ebi: ebi@10000000 {
>             pinctrl-0 = <&pinctrl_ebi_nand_addr>;
>             pinctrl-names = "default";
>             status = "okay";
> 
>             dsp0: pef24628@1 {
>                 status = "okay";
>                 compatible = "intel,pef24628";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 reg = <0x1 0x0 0x8000>;
>                 pinctrl-0 = <&pinctrl_dsp_cs1>;
>             };
> 
>             dsp1: pef24628@2 {
>                 status = "okay";
>                 compatible = "intel,pef24628";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 reg = <0x2 0x0 0x8000>;
>                 pinctrl-0 = <&pinctrl_dsp_cs2>;
>             };

I'm not sure about those 'reg' settings. IIRC the first should correspond to 
the CS line, on at91sam9g20 the 0x40000000 would be CS3 (which is used by 
NAND, like in the dts snippet you posted) and 0x50000000 would be CS4. Are CS1 
(which is used by SD-RAM) and CS2 free to use on sama5d3?

Maybe that's different on sama5d3? I would check it again.

> The pinctrl for ebi should probably be changed however, I am wondering
> how the (platform ?) driver can access the adress ? Should it parse
> itself the parent, and find range, etc. Or is there an accessor for it
> ?

Probably. This is what I have for the at91sam9g20:

            pinctrl@fffff400 {                                          
                ebi {                                                   
                    pinctrl_ebi_cs5: ebi-cs5-0 {                        
                        atmel,pins =                                    
                            <AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
                    };                                                  
                                                                        
                    pinctrl_ebi_cs7: ebi-cs7-0 {                        
                        atmel,pins =                                    
                            <AT91_PIOC 12 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
                    };                                                  
                                                                        
                    pinctrl_ebi_nwait: ebi-nwait-0 {                    
                        atmel,pins =                                    
                            <AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
                    };                                                  
                };                                                      
            };                                                          

> Maybe can I just manually toggle the CS GPIO, and don't try to make
> anything more complex than what it should be ? The driver should not
> be atmel dependant...

As Ludovic said, you should check the settings and timings for the external 
memory interface. This could look more or less similar to that:

            foo_bar: foo-bar@5,0 {                              
                status = "okay";                                        
                pinctrl-0 = <&pinctrl_ebi_cs5>;                         
                pinctrl-names = "default";                              
                reg = <0x5 0x0 0x80000>;                                
                                                                        
                atmel,smc-bus-width = <8>;                              
                atmel,smc-read-mode = "nrd";                            
                atmel,smc-write-mode = "nwe";                           
                atmel,smc-exnw-mode = "ready";                          
                                                                        
                atmel,smc-ncs-rd-setup-ns = <7>;                        
                atmel,smc-nrd-setup-ns = <7>;                           
                atmel,smc-ncs-wr-setup-ns = <7>;                        
                atmel,smc-nwe-setup-ns = <7>;                           
                                                                        
                atmel,smc-ncs-rd-pulse-ns = <56>;                       
                atmel,smc-nrd-pulse-ns = <56>;                          
                atmel,smc-ncs-wr-pulse-ns = <56>;                       
                atmel,smc-nwe-pulse-ns = <56>;                          
                                                                        
                atmel,smc-nwe-cycle-ns = <77>;                          
                atmel,smc-nrd-cycle-ns = <77>;                          
                                                                        
                atmel,smc-tdf-ns = <0>;                                 
            };        

As you can see, quite a lot of settings are made, all depending on how the 
memory access is supposed to be configured. You should look out for details in 
the hardware manuals of the SoC and the devices you want to connect.

HTH & Greets
Alex
                                                  
