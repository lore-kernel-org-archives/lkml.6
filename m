Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB249C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837B9206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1wB7WWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837B9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeILB6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:58:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILB6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mZ5jfq3XrY24i2zwuiQ23jzkFXBQZwWmS0gSCYdf0kU=; b=f1wB7WWzQkBZH8tfnxcmoDPZ3
        SOkdkrEZwem6OH9vX0maKlq/H7ch7jHeoMqLDS5Pu2Ga2uTWD6unPjIR8/Pxh8NDfA8ylPf9njAPu
        vNs5OE5D9lsOL9meZjAA4aM/xl2G/g/IZRstGznta1ODAUlVmWSWHx9fh5A9w5h5hPCISRRAv5deb
        vmcwliKu7AyYBF9545FcrlbQL1iFvT0d9w0iuE5eonthdpgAxg0EmCh9Rt0kd17kOX1U2cJl5OBFN
        QRCDYZPTTKgocX64FYeGkJPw4/M6l+aU3yQ8cZCwgHep8rgoxcmwZFnuwY3UdVbwhw/cYRw3ByuQB
        //JTMuUVA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzpjI-0007Wo-0c; Tue, 11 Sep 2018 20:57:48 +0000
Subject: Re: 4.19-rc[23] iwlwifi: BUG in swiotlb
To:     Johannes Berg <johannes@sipsolutions.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linuxwifi@intel.com
References: <0c5e53e5-2afa-8d38-0b48-272c670c4bc5@infradead.org>
 <1536651177.3224.106.camel@sipsolutions.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8bea4cfc-4b16-7c7c-3e9a-5b6684b47345@infradead.org>
Date:   Tue, 11 Sep 2018 13:57:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536651177.3224.106.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 12:32 AM, Johannes Berg wrote:
> On Mon, 2018-09-10 at 19:17 -0700, Randy Dunlap wrote:
>> Hi,
>>
>> Any ideas?
> 
> Hmm. Is this new?

I can't be sure.  I've been having problems booting this laptop for a few
weeks now but haven't tracked it down yet.

>> 2018-09-10T18:47:54.532837-07:00 dragon kernel: [   31.472371] kernel BUG at ../kernel/dma/swiotlb.c:521!
> 
>         nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> 	[...]
> 	BUG_ON(!nslots)
> 
>> 2018-09-10T18:47:54.613655-07:00 dragon kernel: [   31.490325]  swiotlb_alloc+0x88/0x170
>> 2018-09-10T18:47:54.613656-07:00 dragon kernel: [   31.490329]  ? __kmalloc+0x1cc/0x200
>> 2018-09-10T18:47:54.613657-07:00 dragon kernel: [   31.491652]  iwl_pcie_txq_alloc+0x1d4/0x3b0 [iwlwifi]
> 
> There are two calls to dma_alloc_coherent() here, should those even hit
> swiotlb? The sizes of those should be
>  * 256 x 128 (32k)
>  * 32 x 256 (8k) [TFH, unlikely to be the case here]
>  * 256 x 256 (65k) [TFH]
>  * 32 x 64 (2k)
>  * 256 x 64 (16k)
> 
> 
> IO_TLB_SHIFT is 11, so we get 2k alignment, so even the smallest size
> (32*64) should result in nslots being 1?
> 
> In fact, unless the driver passed *ZERO* as the size, this should never
> happen (hence the BUG_ON), since ALIGN() would take care of rounding up
> any smaller allocation here.
> 
> Presumably you can reproduce this pretty easily (and I don't know what
> specific model of NIC you have etc.), so perhaps you can do something
> like this?

The wireless NIC is Condor Peak:

04:00.0 Network controller: Intel Corporation Centrino Wireless-N 1000 [Condor Peak]
	Subsystem: Intel Corporation Centrino Wireless-N 1000 BGN
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at c2600000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0800c  Data: 4162
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <128ns, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 74-e5-0b-ff-ff-2d-dc-28
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi



sigh.  I can reproduce it without the patch:

> https://p.sipsolutions.net/aa0dccd7a60fe176.txt

but with that patch, it just hangs after about 25 seconds of booting
(slow hard drive, not SSD).

I'll try some other ways.

-- 
~Randy
