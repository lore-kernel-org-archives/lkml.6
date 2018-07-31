Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D619C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECDE20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JMhmOZ3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECDE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbeGaRpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:45:35 -0400
Received: from mail-db5eur01on0126.outbound.protection.outlook.com ([104.47.2.126]:22517
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbeGaRpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR+HKkO9+n87WQnFtEYHA6nxuq1/6lPipeg8wd5q+aU=;
 b=JMhmOZ3iJY0mA4oPbhDih4znPwd2d2rsM1p+F5rH8fBDwRObH3GxbZPGu42hdmwMFUCnUl7XSdQNTao0QH4EO9B4cn3PxB0tPFI3Sl4JFCocJOW+Ljx7K9atTB8N6z1rfrMG+OW15fsNnIRYyPGFf5yLkhc3OMgYPaFQV/WTogo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Tue, 31 Jul 2018 16:04:26 +0000
Subject: Re: [PATCH v4 13/17] khwasan: add hooks implementation
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        vincenzo.frascino@arm.com, Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
 <09cb5553-d84a-0e62-5174-315c14b88833@arm.com>
 <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
 <8240d4f9-c8df-cfe9-119d-6e933f8b13df@virtuozzo.com>
 <CACT4Y+Y=61VwwETQP3FwAN16ompSNJOCyDCG6Ew1Bm5f_Fe1Lw@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <b6b58786-85c9-e831-5571-58b5580c84ba@virtuozzo.com>
Date:   Tue, 31 Jul 2018 19:04:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y=61VwwETQP3FwAN16ompSNJOCyDCG6Ew1Bm5f_Fe1Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0211.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::11) To DB7PR08MB3257.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe8bead1-caf6-4465-ccda-08d5f6ff4c93
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:fKxdAXx4Mdq2DHoTGPgFss1FdMzLwZhNyJ7rez0j43jorhJYOjR3N34DG2BCo9+QZiDvU/uB2DubBu6DVKu4gSfohuo2UP8j7ZQ4mL6RjmpKKZfIBcKfyD5alxKlWHnmSZLI5Elo27awWziyi1nKOBsH++cOKnmDX2gscYY3b0Z/Xly1lmTuMjSoShKKvluZ4SJDuODXqXBc1PJa52TaBea819ux2jrdyCo6My3J21cZCTKCpBFA7J7lPhvDMEz/;25:L7Vz5OBL7bY5AnDJzXj1rESAKGhPqlGtlQcrzHiFkZBzcoLMleBnTu88i/rjMti6DfKUoHXsNsfVmA1cuyGXdUyWFT1xxk4kyZ7T489qdKXL4n8LDLgBgSVjvq4TFL5YPAr9bBYurdEvwub6Bv+Y5llRaMPLVLKG+3NtQy8X0CCmmR9BvmYcovCu8FWJIiHKoe0FveZzW/bhvy9jjZb1nBU3iEX3NUNj08hb0g++1WCn0nlDEKFYVdoofOQ0lP9hnxMPwtKnpSR2YZA3e/bbivJ9+Q9Li3aJfp76N2RC1eXoCVPNMinDlNeZJKUg/EDl/PNZfvmJNGh6F/VbpHHh/Q==;31:HFLSrkwDB4pOb4VZIt2vtiPHXBiV9Z2yxV67emUkkT4wlyh3YAxnVuzYVqozmXor+AH3e4gsB0B11HvE4i+TcSpUrU9sTkfJhwgHG4oWXvjmDtIcVGTWh+xn64Lw1Lzx15WqQvEnYC20y/PVMPOmPCP24/LHCw6xtGQRtyhTCeggMidMkkeGseJW95C+IwoF1eDhTKENTQI9/L+k2Pc0eko4NMshm+uHT3zml8jE8Yg=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:7Wi0ykJzEizCCe7Xg9FJ9vfh8G1FP3MOowe/PEMN7+l3HsR1PRPunhp0ZoyYfZ3VfRCd6pznqcecEdp0SIVaeKjX41zEgTLXiQsqT+iBrMvl6WlBKZcGkt77vgAthJDQS3CcltykSXoBJAnZvMZodEICaymwT9sSP8JNujy1z8K5zaw+m4lGUDFu8ArgiMWzD5IJVrPs7weSLJFaOzV0qhV/J5kFuxCvILcUWfourQb5rTrP5Y/opW3Aq4MwhBLx4wq/IovXpKfVX3tOJ6ggF0a3k+7b/CqxWHFvaF6TnZo5h9YrTddQ32HWhcFA3gFJIyueHiYFhIRexRSvqFyga8VC86Yu163ysNgXy/GW1JDjCR9x7vuZRm+S7lUmeZvv9rc1SJrLFq9CjGakETuZKL/Jz4sNp9xWRDb4UyxnGSPCCvbAk6KeZxuAy6Mql7z/GD6u54n6vi9NwgsxLKyyhCCehB9krMw19c2qtFiTj2bTU88eAenFClZ/Ow1TKZKv;4:r9F0AbOx6HYUxfyTdUONRuWJDxGhCbaRJOQufXvmc1FLNVO1z34++SgShUz1NtGUDewpw+ZAlXPv3f5AQMeMX7NnCRA8OlSbWSkowbD4dNVMb0B99Oacd8F4aGtCkf5XTyscQhR6Ieh2T6rNVd5VAsBQObWRoOyw54yx9PGP16MZlmlfXmIAEMxsWxvEaCufU7NRr26Ha+sMj/XmCCR7gB0JSXFtpsqAUUNPNKzn63x+hmqhBhCTVCGWL/oWXuMLpW81kwv9tO40zBYi6bYka4yJldJNmiDH0GF0/RmEOQ+huv3ZDS9u20kRv3b+wnbh
X-Microsoft-Antispam-PRVS: <DB7PR08MB3257474E8C172A1553E7E47AB02E0@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(136003)(346002)(376002)(39850400004)(189003)(199004)(14444005)(446003)(8676002)(54906003)(386003)(476003)(58126008)(81166006)(26005)(81156014)(2616005)(76176011)(93886005)(956004)(316002)(53546011)(64126003)(25786009)(77096007)(6306002)(2486003)(53936002)(478600001)(11346002)(305945005)(3846002)(47776003)(16576012)(2906002)(65956001)(66066001)(7736002)(6116002)(97736004)(8936002)(16526019)(105586002)(5660300001)(23676004)(50466002)(65806001)(6246003)(52146003)(486006)(36756003)(6486002)(65826007)(106356001)(68736007)(186003)(52116002)(230700001)(31686004)(7406005)(4326008)(229853002)(31696002)(6916009)(86362001)(7416002)(507254003)(556444002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU3OzIzOm9CYWJZdk1aSUdnSjBnOXgvTTdCRE5XZEs4?=
 =?utf-8?B?UEs4T3BYUFlpVUVaZlVvOXY0Rzd4MWhDK2dkM0NPM1ZqbHBMZkw0VG1nVzM1?=
 =?utf-8?B?Qk80K1l1NnRaVy9CNjJ1S3NkMEs3V3c4R3l0T2lKQVFMVDgzVTU2ZlZBUzlj?=
 =?utf-8?B?bmZRc1QrWFBqQkdXQXpqRi9rL2p1MUQyVlNPWHVRbVZjaW5aN0xNTzlsVEJk?=
 =?utf-8?B?SHN5RTJIZnFPRzRKUlcwSmFyNGtPWi93VVA1MDVlR0xoNVY3bkhNdjEyWVFr?=
 =?utf-8?B?blRwOTd4eEU0cjBPM2xZZVN2TUVzL3dvMVdkQmFlN2NudGtNS213WnRqOUwx?=
 =?utf-8?B?RE1QZGtyZW9GQ3k1NGlaQm5lMEtMdEptUkZYVE5GdkxWNDl4dnBjTEhkRE1q?=
 =?utf-8?B?Slh0WS9oMjZFenBlQStVazdqM3lyT1JVekRxN2FjMUNRV3ViR05EUnRMckhu?=
 =?utf-8?B?bzNOZDNJMjZlZmdOeHpUZUpQcEd0aFJUc1FQWUtCQ3I1VC9uMnVVWG9nN28w?=
 =?utf-8?B?R3hNL0I2eUZ5L1l5UFM1VHRSTjFoM0ZNZEViajNERTV5MkFiSEl4dzRFUDhQ?=
 =?utf-8?B?WmZqSUtzWm1IVEJIR09tbG1kUUdDemdZZGJCTC9NQU1xMXl6aHA2VWhXMWFq?=
 =?utf-8?B?eUdoMVJYSXNmVDRTQnFOOW8zMjQyV001U3JLTHM0M0daQ2dTbVE2YWp6ZEdI?=
 =?utf-8?B?WnB0QlQzWmIrckFyRERQZ1JicHQ5UXBNTUpzcExWcE9FZlZDNUNXYStDUEI1?=
 =?utf-8?B?L1NjMGxXVFc3NitFaENxZStqNVJ2WDZSNzBiYTRobithZElIZTVueENEVjNy?=
 =?utf-8?B?ZnM1a3p4dVFFYVNHMnlyd2hkN0RVdklibFc1QzFCMEdWa3JsVmlPVzgxL0Er?=
 =?utf-8?B?bEJ1Z1lZQWE2NENhOTBCK0dUZStsKzBiN1FmTUxLWjRUcUZtdk9oQVNldDJD?=
 =?utf-8?B?eFUyUmhPZVFESEM5d0drRzdqMGR3bldkay9WU0F4Q3lITXE5NWhYTWZwTnpV?=
 =?utf-8?B?cTlkSURtM1RZZUFndWxVNzJ5VGwyR2NETDZMUlAwMGJsQnFxa2JxdmtyMGd0?=
 =?utf-8?B?dW1XZVliUEEvSkI0RnNMbVZTd3g2Tk1kSXNMU0N5S2dzTjJ2Z0d1dTNITDVX?=
 =?utf-8?B?NlhRemRoQS9wdncwYnBQeUFQRmFXTHJBTmxER1pVaERrL3JWWmVVbjR3Wncx?=
 =?utf-8?B?YWJEVVpTcUZkeEowVmtsWjRKSVlhTmhNRFpQZ3BWcHlBcC9uRW1pR2FOZm90?=
 =?utf-8?B?YUR4NTBJZ2FFOFg4NWt5MjVHWkdTUUM0Z2hDQWphNElNZFZJaVFsSWhDYlUx?=
 =?utf-8?B?Tm5VNjdWbEE4OWU2VS8yMXlUWGZ0b3ZuWjRCMnpabml3YVVueVJla1VwdDNq?=
 =?utf-8?B?SjQ4ZU1NakdXaStVK0I3SFQ2ckJ1clBkRGtUcmJHTTduOHcrb2NJOWV4bGEx?=
 =?utf-8?B?cmxVdHF6U0ZURGdPOEtyWHhldTFDbnQ1TGZ3TzVMVzMxdVVWcUt5elVnSlpr?=
 =?utf-8?B?YUg4aHVxdm93WkY5cDR5NEdDeEVpeHVaYnc2bVE3eFVSYWtvZytGUDFNNHZO?=
 =?utf-8?B?SDZueGRwSm9LWjh0WE8raWZXckNIajZxcnA5bnRFY1ovNFRqTEVlOUd1V2ZK?=
 =?utf-8?B?N3hIMUt3bGFsQU1XWmovWU1qc0lTeVFoUEQrdmowUngzUHdsdi95MHR3NzBk?=
 =?utf-8?B?RndxL1k1UkkxNUQ2emZ3a2NYQnMzVWVoNXVaa3pGN3grT0NnM2hSYWZSeWwx?=
 =?utf-8?B?dG56NVNRazhUZU1jSFJZTkJnSmNUT29LTXdyRFAxSlR0dEdGdHViVUNLbG9X?=
 =?utf-8?B?SG5VcVJDVllJNDVhaVFDTFVLVVhuRWlQeWJDWE9mNG5TY0d6Ly8zTklzUHZt?=
 =?utf-8?B?Mlp2V1dOdW5oL0JGcmlKUFBPOWkxOHo3dkZQNjJMbWhaeWpvMExBaUEyVkh5?=
 =?utf-8?B?dThLWXNPblN0RnJDQkIvYnpIRmxjMVZVaWk4cm5qYW0wRzZPUU5CSXJxVEZl?=
 =?utf-8?B?L3BnTnArakMvdDMvSEFCLzNPZjdiUEcrQUxxSTkrUXhSWk51Zi93cVlmN0x3?=
 =?utf-8?B?cWtuaTBPdmNtZXRiemJyV1ZvVHBHRXlTbTJscHRHbCtDTjR1V2drRm80M0NH?=
 =?utf-8?B?NUE9PQ==?=
X-Microsoft-Antispam-Message-Info: WZdOnLwmKQ9NOCX4/g5+MVYMLFUzcd5rx+xDvPE25JEA/0q7x7lUJEwXxclHRfn4Bobljx8vJ09KYzPLQxsiff7gFN7m9Hkxj74d6rWB3f6n5khOJ5U8ulDtwEm6sZLbfxVxpf2ifnN3tq9h/066ZF4EFUK+k9fhbRRGm831II1P6F7lNMNZeEGLKTTBH/EvIXXD8VJClN4os06ERjTDOB0G3mYf1SyTp89u0KOHhVOOuEXDpSwPf1Cxs5mGo8tql9l/EQsx9WXknK22XhJQkW5GttyGrXbzL2V+j9teF2S+omLqjeOp/IzubcnofY9ALOWIHnnqTppRQ9fMdVXKHQCoF0sygj5/5cVGsqv8p1Q=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:jhHRRiFTR1yVQ6fGjWBFw0DIxYJWDEcpunl6OppZxv6eyjFu5rydnaViinnVcHmzY0StGHcBCB1Ffhjr3s8/Pk0WaE7cOJrahcb5koPLBH2ALHSfxO1PyoCbG/sa7Jom0DZA+fqOy6Dw4Q4AU3lunkzT+OCdVbIIYWgRQNQjZ8k2SidaPmKujGTtoNx0jqXvL2ey80XVQS7GP8Iq3r43CeZmWkLftmtVwqmiV8dOP+M/4GxFCwhK1Pjp23s46PQrn/KzCpDCF7SgnTMj9gpqtrq7M8zsZvqckrQ9ZkGLFgha9yFmuK8V9fYaotmLKSVchdA1GewHEX+4+wXukATJsDmM25539oIyNX16pP+uanlNpQRDCGYUfaJZ8vuYIYyBa4HB2M06RHPRL0L9UR2wscdMegxxM4yE83aicVaHui1tJdu1TXjvkvkCMiV3yCB9y1QNuQGvmDQoyl/Nuip5Pg==;5:CCa82Q077eeROeucHVpLtRLg/v9r5/L95m7YYQazgPDUT17uKInOk2WfLi8D4oy3qdp1p3OZkVXfGil1reKQ+6lg04UDSeZcjlBEhMcHnW5O7zkN2f/x59n5jzBYGxPCIazPoxyhni0WY6TbqutSDMZK3hGL1GOoMu0YvZhESMc=;7:DqZaOMcTmSv0/HBhxpXsvObb5Nosf6MMy36C6EuzZZrYgMwOjMl/SiZ4c/tThz4i/qCw5Doh3ZAnVxl6txiZ3G3ETkGVY/xlO2wo3b6WM4+u3BEzHKfzjN6/8cIWN3TxCgwtwQT1TXmsCzYoYPF//cyIlwZBsikuJUpEcdc4C+SxQ4SNsjSxF84/7Q57B0hA5E0o9R8sQlEoRvxr8KwTWbXR3YFSxt6zREyGyR06LLTVE3DoSnHcwT5NxZ0PU/Ot
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:f8ilW5mL+bwkY8wo1mhIZwmBgZhMVETLy8pgTy/Pxao7Yi2BaUbp4HuJJYkpsGd8fa48IteYzDcBv1geDI+4JF4G94bVi26MNNueKGO0PpiDic5r2PiA+knL2S1ncehDSIFRQOptcotV7HoqN+0gjwWVBdOesmmxDqX7p4oLiDk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 16:04:26.7405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8bead1-caf6-4465-ccda-08d5f6ff4c93
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 06:03 PM, Dmitry Vyukov wrote:
> On Tue, Jul 31, 2018 at 4:50 PM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>>
>>
>> On 07/31/2018 04:05 PM, Andrey Konovalov wrote:
>>> On Wed, Jul 25, 2018 at 3:44 PM, Vincenzo Frascino@Foss
>>> <vincenzo.frascino@arm.com> wrote:
>>>> On 06/26/2018 02:15 PM, Andrey Konovalov wrote:
>>>>
>>>>> @@ -325,18 +341,41 @@ void kasan_init_slab_obj(struct kmem_cache *cache,
>>>>> const void *object)
>>>>>     void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t
>>>>> flags)
>>>>>   {
>>>>> -       return kasan_kmalloc(cache, object, cache->object_size, flags);
>>>>> +       object = kasan_kmalloc(cache, object, cache->object_size, flags);
>>>>> +       if (IS_ENABLED(CONFIG_KASAN_HW) && unlikely(cache->ctor)) {
>>>>> +               /*
>>>>> +                * Cache constructor might use object's pointer value to
>>>>> +                * initialize some of its fields.
>>>>> +                */
>>>>> +               cache->ctor(object);
>>>>>
>>>> This seams breaking the kmem_cache_create() contract: "The @ctor is run when
>>>> new pages are allocated by the cache."
>>>> (https://elixir.bootlin.com/linux/v3.7/source/mm/slab_common.c#L83)
>>>>
>>>> Since there might be preexisting code relying on it, this could lead to
>>>> global side effects. Did you verify that this is not the case?
>>>>
>>>> Another concern is performance related if we consider this solution suitable
>>>> for "near-production", since with the current implementation you call the
>>>> ctor (where present) on an object multiple times and this ends up memsetting
>>>> and repopulating the memory every time (i.e. inode.c: inode_init_once). Do
>>>> you know what is the performance impact?
>>>
>>> We can assign tags to objects with constructors when a slab is
>>> allocated and call constructors once as usual. The downside is that
>>> such object would always have the same tag when it is reallocated, so
>>> we won't catch use-after-frees.
>>
>> Actually you should do this for SLAB_TYPESAFE_BY_RCU slabs. Usually they are with ->ctors but there
>> are few without constructors.
>> We can't reinitialize or even retag them. The latter will definitely cause false-positive use-after-free reports.
> 
> Somewhat offtopic, but I can't understand how SLAB_TYPESAFE_BY_RCU
> slabs can be useful without ctors or at least memset(0). Objects in
> such slabs need to be type-stable, but I can't understand how it's
> possible to establish type stability without a ctor... Are these bugs?

Yeah, I puzzled by this too. However, I think it's hard but possible to make it work, at least in theory.
There must be an initializer, which consists of two parts:
a) initilize objects fields
b) expose object to the world (add it to list or something like that)

(a) part must somehow to be ok to race with another cpu which might already use the object.
(b) part must must use e.g. barriers to make sure that racy users will see previously inilized fields.
Racy users must have parring barrier of course.

But it sound fishy, and very easy to fuck up. I won't be surprised if every single one SLAB_TYPESAFE_BY_RCU user
without ->ctor is bogus. It certainly would be better to convert those to use ->ctor.

Such caches seems used by networking subsystem in proto_register():

		prot->slab = kmem_cache_create_usercopy(prot->name,
					prot->obj_size, 0,
					SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT |
					prot->slab_flags,
					prot->useroffset, prot->usersize,
					NULL);

And certain protocols specify SLAB_TYPESAFE_BY_RCU in ->slab_flags, such as:
llc_proto, smc_proto, smc_proto6, tcp_prot, tcpv6_prot, dccp_v6_prot, dccp_v4_prot.


Also nf_conntrack_cachep, kernfs_node_cache, jbd2_journal_head_cache and i915_request cache.


