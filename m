Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FB420673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FB420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbeGZW2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:28:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:32833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730402AbeGZW2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:28:47 -0400
Received: from [192.168.20.60] ([92.116.181.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQiVh-1fZChp3Bcb-00Tyc9; Thu, 26
 Jul 2018 23:08:25 +0200
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, benh@kernel.crashing.org,
        paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <87d0vehx16.fsf@concordia.ellerman.id.au>
 <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
 <20180726125940.GA15033@ls3530>
 <de188e2f-99ab-53fa-20df-4fec00a935e9@ghiti.fr>
 <6ec7c5dc-feb1-86ff-b7d9-7794c92eaf0f@ghiti.fr>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <91e66af2-9f59-624e-6839-eeadb47b9bee@gmx.de>
Date:   Thu, 26 Jul 2018 23:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <6ec7c5dc-feb1-86ff-b7d9-7794c92eaf0f@ghiti.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lx7/42WCXkUxJ1tcDGk55ahiOOjEn8MpWO4JQW/7OzyygKvPh+j
 icggxuN9uheEXwoTA68muLmVvpeBV2oJAmt5P0A034FfYi6eH0C+gJRL1KzbzGjsk3g88WR
 yGn2sA9O1qyFzuiNaTQEpgv0g8ZIQonJEUdWarUmOZCUxHSeTdRuaYxC7vX3VJjip4TRBIw
 N/gcSoif0Y4VlWdxKTpfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AXm+gX+ViyY=:9DAt0GtGjKTgUorFQiZS3e
 fZjtUs7tD94ADOvtQTq3m43Xpx/BwiIl+jlNKGOg3RiiPJkhHirXCihKTnXisDq0pSPcoLHWX
 w0tWsQ1aMFK5eKEn2zVkt5ZrTDd1VW2FeS/bvf6G8hbWyeKVrgXrVtkGYNRgTaVx+9nLk23Z3
 xgB+gfoueM1vJ/n7Zg3RvzHITmkHEkkAPcX6BHpBY/DdXcj0ScVtdqK5qNXTB/yEvdCp7d7da
 lWiQ0yfgmApFtjgDu/sM07QA0mDM5WvUmk7f8Ny1w6jqCCrLyNTp6B/Uiuh1lf/V+GXngKv/j
 xyLbkScuajPYZFa9Hae6s9o9CBzpOdQJ9ms8WyCsMVLxCHvyYkj+YB6fu8Ey1ROr9IRIeMJxj
 z0phX/aUKrC8slJ4m/r5URzaAoh41E6BgnIpIoirxZXwmdSUG1VffZa5TzMyfNsDj9BI0A+G/
 V/uZ1xs/evVRcBhfeXvRc7Qo1DMk+IU45WjoujKnU0vhbfHvlkFWMKzDUbw536M7t+1O/DDlR
 h3J1NMmh34ObFT7L26FxxUIP4hK87j3i0pX8tjf5++Unm4ShlD8KiJB1ZGFVvdngQoOiz61Xr
 EMokKsHmT8sIEZ6tBaT4jwVSqxbHJzbptQl215xMrHvlhJLKFrmv+JvoSk5psecIVQp/gNCcb
 +U8SBob0T/pVrADjB8W8+6mC3gR5Z+kue1LSzqEhfrvuhqZp8EZl5v/TJqjQNdZMoLeO8NFcW
 yWK+oPx3lz5XBMe5wG+Xok+TSPVA55OSRK/PXXVX0SWa/ugoCVbzAFmAHnCqzj8BK2Z2hmSNR
 YUFq3uB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 26.07.2018 21:13, Alex Ghiti wrote:
> $ make ARCH=parisc O=build_parisc generic-64bit_defconfig
> $ PATH=/home/alex/wip/toolchain/gcc-8.1.0-nolibc/hppa64-linux/bin:$PATH make ARCH=parisc CROSS_COMPILE=hppa64-linux-
> 
>> ...
>>  LD      vmlinux.o
>>  MODPOST vmlinux.o
>> hppa64-linux-ld: init/main.o(.text+0x98): cannot reach strreplace
>> init/main.o: In function `initcall_blacklisted':
>> init/.tmp_main.o:(.text+0x98): relocation truncated to fit: R_PARISC_PCREL22F against symbol `strreplace' defined in .text section in lib/string.o
>> hppa64-linux-ld: init/main.o(.text+0xbc): cannot reach strcmp

In order to be able to link vmlinux, we need to enable 
CONFIG_MLONGCALLS=y in the defconfig.

Nevertheless, I see some modversion issues too which I still need 
to analyze (but that's a completely off-topic issue here).

Helge
