Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeECIwz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:52:55 -0400
Received: from smtp-out12.electric.net ([89.104.206.35]:58396 "EHLO
        smtp-out12.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeECIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:52:50 -0400
From: =?iso-8859-1?Q?Bj=F8rn_Damstedt_Rasmussen?= <bjra@terma.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: SWIOTLB buffer runs full
Thread-Topic: SWIOTLB buffer runs full
Thread-Index: AdPivBr4uiBu7YalQHS4xag4G7VuFw==
Date: Thu, 3 May 2018 08:52:46 +0000
Message-ID: <5BD0C36065EAAD4BA6A60ACFBB09F30AE5B7B72F@Exch03.terma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.5.171]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Authenticated: smtp.out@terma.com
X-Outbound-IP: 193.163.1.101
X-Env-From: bjra@terma.com
X-Proto: esmtpsa
X-Revdns: r2d2.lystrup.terma.com
X-HELO: EXCH01.terma.com
X-TLS: TLSv1:ECDHE-RSA-AES256-SHA:256
X-Authenticated_ID: smtp.out@terma.com
X-PolicySMART: 6001202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a long and bloody battle I managed to port Xilinx's Temac ethernet driver (drivers/net/ethernet/xilinx/ll_temac_main.c) to Intel x86_64 platform.

The Temac driver tries to allocate up to 512 DMA buffers of 9018 bytes using dma_map_single() during high load. But when there's high load I start getting this message:
	xilinx_temac xilinx_temac.0: swiotlb buffer is full (sz: 9018 bytes)


When the SWIOTLB buffer reports full then performance drops significantly and the kernel log is being blasted with the above message.

If I reduce the DMA buffer size to 2000 bytes then I don't get the above error, so I guess the problem is because there's only very few DMA buffers greater than 2K bytes. I tried appending swiotlb=131072 to kernel parameter (i.e. 256MB, default is 64MB) but the SWIOTLB buffer is still being depleted.

So my question is how do I increase the amount of DMA buffers that can hold 9018 bytes? Is it a soft or hardware setting? I run Linux kernel v4.4.97 on Intel(R) Core(TM) i7-2610UE CPU @ 1.50GHz (family: 0x6, model: 0x2a, stepping: 0x7).

Bjørn Damstedt Rasmussen
