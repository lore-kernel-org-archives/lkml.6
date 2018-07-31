Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2945220841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TQeDazrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2945220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeGaQay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:30:54 -0400
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:45591
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732319AbeGaQax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOZUj+slwPdTcLPb5dh1byVigPPmrfGDI9mil0Rjj9s=;
 b=TQeDazrkzCLuYs/3IIklOHCLLbMIkqNFsxvkfit23uSqElVpyJmcCo0MTTK0NTJmEFA0duuNkFWo0TSsj+ou43AJrTKPuI2sYONMsblpsbL2LbTl3kjDq69q75PtcH6eHFFJNFPhkMmc4f3QkLSYulNT8xjY7uSMHHp0o4pvIRQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Tue, 31 Jul 2018 14:50:00 +0000
Subject: Re: [PATCH v4 13/17] khwasan: add hooks implementation
To:     Andrey Konovalov <andreyknvl@google.com>, vincenzo.frascino@arm.com
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <8240d4f9-c8df-cfe9-119d-6e933f8b13df@virtuozzo.com>
Date:   Tue, 31 Jul 2018 17:50:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR04CA0092.eurprd04.prod.outlook.com
 (2603:10a6:803:64::27) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d261fee9-eabd-4091-4181-08d5f6f4e6c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:IlEaj6XtlZp/PB5QoBvssXfYHM2HHe5nBsWRgSBEssLbB00cu36xLrgOiXvV5d8loy10d5qw7TR/3MXjl27826yoltZVbvf5n2W4cPgV0R39WY+b6WfTPRav12foPUcAD8Gjweo4vvap0n2GYS0nfRFlLaKB1/g4oEinuj/VaMzf7Z0gEpCkf8doJU2YEuUbOU9CLlv0O/5DiUMiwQb5yf7SNyM09qUlz3PUswaV8LGrHtE9AVpzu7L19SU+beC3;25:erGPKZ78rcBg0x801Lyswa2+GbuVj91Nikw6XJ/q+L7dfZdCwuETYk6Sp+3dTooS/yNVe0IX+C26wx59GgHzDVYr1f9w00Jpa8H35yEQyTRG31ZXEKEfK6TsMeN7M0d66CnBpMolWifn5M4QOjrKXUpJZDha7WdzslA3dbfD0WmSXwJDPdWS6mp1MdR4u5zAGQiA4RFYFY0C3HXAWnXVYfo7/KyBjbBZ//vPVg19fPVfChas7QGA4GNVU1Fu4pgQ/2PchPimurcydPPLRs11wLXM9ga9SA2ZfCcNQLIeHNxPeASp4sPLwq840vLijyCp0Pwuz6q5akPefBwlUojxxw==;31:8M48M5MVbpzaGb1VkE70zI1awRWaLTl5iyN9DQFCNDGfIhQAgHmDzy8fYAogJ2YUzE2KhDejFGXsYumHr/kFYLclphkEKyDKOJGfoUkrlnvVQ3gVdmyT3lkTVNflNybzj6IE4QPC76vHMfzhW2i0d0JUqZhBFPaZdC/CascinRQyVZfkj/E5/zVEBkTdYGHIiNx8wi0/oCTHNaUZ/R16Xbuv8CGWJvTpExuBZbR9Utg=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:DuvzMr69gX/OEXkdUD65vFO5MJZQPjC79+gCobbc3xdhaX+6XIY8vmjglFPhD+Su4MnXJfJajHmYjqLPctVLr9kFrV/l0tjYrDh4GWlx12eRgkUTqywoHKrK5yLPglhBSdSurXvqqdrC6IUTCLcYRj0O2XHaUGJydnQXq4oZJENqxrwN/LOS3Zk2V0QyNk2ApByq9SGKZpsm/BsbR6/L/GRVowXbDCjfx+AU5935T8lNLXe2Cz8/TsQMt1CyKNQk/o5+2wJLZO2LnKnjdBtiuMEx9sznwVYLvdrPbtp0MyoguEG3qeZGYah0GFoZ3KP3FH9ecgQCJVRlXJM6FCzzzHvwHI4czpZpMpa4o0ydWsWBx5ViY0ntPlkpEF5VPGtUw7nz7kJQ0FR4sPp19R87RjkKMK9XahqKpwZFogz9dEYPmSlzl7aUAOWsEz7kV03ni6ydX3wOKTt7hdKGLhfEN4hU4IQchGVanDtoEeRB+AWD3wjWWMvnAtmB4kwqO8cl;4:8vfuVgjoMsxpHRnAHOi7RyDtbsmxAO876l6XXMpkzuqEOp5DttxZKBttg9dN+2WPS8FVu9T+/fjOHgugmdiapm9+Hul4PtF9X+vHAsX+GNvfpvU8PUWxwuJENZJ2kKdgM9UQYkn4PMh4C3QnsNRXl8yWQAIirI2dtel4OVJTPrbaPR0pHMzbJFCExCUe3DCcHZKBRDq/274LON4aLnAQrtQNXCrFhGM2i4Dk5y+Rwlso6f/n1Xx1lZRSeRxToJ1rL061QU9/HyaseVqUyZCi7bvNbCiS5Sl+91YHcEE3JKTt6utKs2Hgs6310OZsl8WK
X-Microsoft-Antispam-PRVS: <DB7PR08MB32581FC9AD6D6EAC1B65B797B02E0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39850400004)(136003)(376002)(366004)(346002)(189003)(199004)(31686004)(14444005)(305945005)(64126003)(53936002)(25786009)(65806001)(65826007)(66066001)(4326008)(65956001)(956004)(7736002)(386003)(53546011)(486006)(31696002)(6246003)(5660300001)(8676002)(81156014)(81166006)(2616005)(478600001)(6306002)(11346002)(86362001)(476003)(446003)(3846002)(7406005)(7416002)(36756003)(97736004)(58126008)(26005)(54906003)(2906002)(93886005)(77096007)(76176011)(52146003)(47776003)(6116002)(8936002)(50466002)(16576012)(105586002)(186003)(106356001)(68736007)(230700001)(229853002)(6486002)(52116002)(316002)(16526019)(2486003)(23676004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOlgyOXR4dlVPMnRMRlYwMGtraFo2eWd0cEZ6?=
 =?utf-8?B?V09vbFY5UXJJZDY1VnNVYlBXMkRWQm04R2FYVDdIdlcvU3B4N3JkSnhaS3Nv?=
 =?utf-8?B?NVE1MnFHRlhvTDV5ODdDV1BVeWZwM0ptYUZLOXNqN0FkdGI2MHp6aWdjN2Z4?=
 =?utf-8?B?M1VPdE1jOVg0cVUwY0hnREk5blpLVzYrbG1iWXAwcDlBTDhCTkc4VXBHc1pI?=
 =?utf-8?B?VVd1OTE4NGxLL09kb3c1MnpObHdTaFZlYStmN3NPeGlRcmV6VElyZmE2aG5p?=
 =?utf-8?B?VnJxeWNhS0htMGNJNml1bjN2Qjhmd0FXQW1MeWIwTHcrYlN3SmFLZGEwSGh4?=
 =?utf-8?B?R2FNSzM0aXdDV3hCUloyN0FWbUx3RkRUcGtxYjR0cjFNQVRjU3Nna1YrSmxL?=
 =?utf-8?B?N08zU3o0b0JJSzJVQlduYXVpcFRSdnVBVTNLZDhsbVh6SFN4NmVHaVF6ZENS?=
 =?utf-8?B?QWRPbWI2RjNtM3VHVmtTNENrVmx6ZW1zUEVqUnVZbTIvbWNPajNrNmJPekc3?=
 =?utf-8?B?NDNxN3UzL1FKa3hBR0lTa1JCcC9MY0U5dTFmN0hac1U0aVFrNjFsQi8rSmFW?=
 =?utf-8?B?T3pUT3J6cTN3L2JrZjFFbEE3TmtGbUlqWUpTVkZOcjlJNWhYdWJaK1YycjQz?=
 =?utf-8?B?a0xZN0duOHcyd0dlU2JPamwxQUpYbUdtY0pEN0tJNTZxNURxK0lxRWlxRkhP?=
 =?utf-8?B?SDlDS2puOVVTOTIwY1BsWTcvZmhwQ1JJL1lzcXBUTnFRTDBUZFB2VzlNZitE?=
 =?utf-8?B?VnlsUVltUnVZY1h0U1JFZW92cjd2V0o4cjV6WmNjMTVZdGsxV3hCYTN3d2F5?=
 =?utf-8?B?Q3E1c213czVoMHFnQTBkYWM0SFhlSVhiUTh5ZFJxL1htTEthWEdQcFVuNkhY?=
 =?utf-8?B?eWxURFhYbXFLMCt2TWFRU2pDOFNsOE8wazR3TTVFc0lxcVM2M1FTcUY0Tk9y?=
 =?utf-8?B?RFVtd0RxS09pYVlnVkdxUlZ1TUlkVUhoOGJ5VlVjYllsTUE1RDVIbmVtWmky?=
 =?utf-8?B?ZUNoc1JLY2xTQU5qUjl3L3orSFBjVlBLcTlvaHVKeFFmeTB4RUhNU2psT29V?=
 =?utf-8?B?RFRYMWZJV09nU2RLaWVSV29JbnFYdCtRZFJySm1XQWMvVHB6azFNRFIvM1JD?=
 =?utf-8?B?TkM3OXNUcDMyM3RqVyswdGVIenFDeVRXbGRPTCt1ZFY0a3ljbHJCZzdWcUly?=
 =?utf-8?B?MUtaaFZLaGlyUjY5b2pMcThNekZubENjY0JYSy9zbG5ZblQ2dFdpcVBvUTM5?=
 =?utf-8?B?a2ZHYWZhZVBRNnpveW1yZTh0WFk0Zm9iQ3ZiVm1aMnVYelV2OFhqa1BieGR2?=
 =?utf-8?B?bmx2b3FYM3VDL3pRZ0Y4VnlFUmV0MmVmZjdpVjNmZkNTYVdWcUVxTlo4NDFR?=
 =?utf-8?B?R3NWUXl5Y08vRjNyQ1dFdWVyVGZRK0huc0pkYitEU2lzTDdpb1B2OUlvREZa?=
 =?utf-8?B?eVZPcE4zQkJ1bTJpNVczcXNSRmduTy8wUEdQN0pVckM4OEY0NlpQaCtiVVlw?=
 =?utf-8?B?bW5LUjVOSXlOS1I3LzIvZEdBSm8xb3B5ZHVVS2hBTHRmWnNucmJKb3hSQUY4?=
 =?utf-8?B?VE9CdDk3WklpWmVmYjJIWDVoVGw1MFZGWUUyWVl0S1NtTTRGKzJyeFpxcTZD?=
 =?utf-8?B?eVBKRitVeTA1MEZNZjVHZm1UODZzbHFoZ1l6aWFVOCtlakQ3UHJEaVRuNE42?=
 =?utf-8?B?M3FGTHFWalRobjNTQ0krUjEyOWJaWCtiY094ZGg5RE5nWHU5YWhjb01DeGN3?=
 =?utf-8?B?RTlyeitrU0d1eUhRTXFLUVdOVHhTQk9TZWdSUXJkb3pObVZKVWM2UTlDR0Z0?=
 =?utf-8?B?QldYemJ3dzFqU0x6QzJjU0NESmwyN3dnTmY4emwxQmhvUnpGUXV6SklUVkp1?=
 =?utf-8?B?ZktrMVkzOHA3NkpaTjQyc0N3UkorUkVHaEZ3anF3aHNrVDBKMDcrRlhoZ2Fr?=
 =?utf-8?B?YmgxSjhxUHo2UUhFa2F3Z1ZIaDZMQW9IK2lXSnlIbmczOWVldW9TZnFjQ1pu?=
 =?utf-8?B?dWlmK1RWcDdaTkt0cURYdXhXRUdwVStwZWdodz09?=
X-Microsoft-Antispam-Message-Info: TiIHQNkrGJZrOwXjslJIr0RYYzxVgLuNFwfIv07QW8jnI20rFVhbi40+SxU9k58tTH22dcwam/usOp8xoTts3trZwatqgD8zseL2PbNIk2GQoOu73cMOH3x0K7NuUdWEAQ2TXA04fmm/TZEMhQ0tQwb/RyvjlJL7a/d7XJivG6np2RRNe35J17dsjLj7wzjNXWw0Nj7KLXGKdXEM92RF6NknG1i24TIyGaz6URh9F+2be5WIQnvPQmZY2ZQBt6EeelL6DbAo+bAHAewQd5dmPdCNQIIHMVwBNCnTCcmTjxQOb7jCcI+vKpEcclJ+i3cXTr0yzqF+HMWCxUxmVV7XZqn1itgTTA82YoNNrz5d5t8=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:jn1nwtF+v+HUSwZ5/9La8OjEjUkUHoepXFpXjAY406zFoZZLaMu/7ASKY+k+z52WAbh8A/03aQKrhmdlabWmn7E1TNT7NAblEv129K1a+ZkHBLZsiSprTdUugREqLqGVDqKa77iL5nvPsnl5EGlybtIh76BLDEhl79W6QiygSi1HGXe1vfiuva4YXPbAv2fCm7qlaCnyTYsyn72bKno30ywEYJPk8CVmYaFGahz2JLOU+E5PSq0/WMnUqLTta17JDDJLhJBscTsi9Lk7r1qbWCmdF4g4tHYED+V0l6Z7NT+6NMWcG6j82SW6x/7YqWxjYzzc3DL7k/n4LNX+i9Wpi9rN8RtM7xtKLrjW2sWoAwweXZ6N42UQRSx62xQ4QWGk6aB+FjwL7oC6JGr775zAK9UM99xjmle7apKya5qV2P/IVWS+OXBESb2sDSSldXz2Ognd3KNbGHhxBv6VOGR5+Q==;5:OxdqeibBgMNh1cntzHNTs0JlAxq8jCWk+ahAReCoOX6/rvFCfbvY5Wc1W+CeiVv9nH2m0451e/nDvtiwwLLGojs0Q6aJrWm8WXSgs1IMPcbFMhc3mosOTzaZ/5N5n7gk/L0qXTdM/OFkZ93ZqOBzcL7LfcAid5NFpr+AGUeMRKg=;7:J/8BLlcOVY+iQD14bUFcZAaXs52DajNZFQ5jVe7/Rhl31mNfhPt41Vy+Rn5Y6ACLCQQNHiSev9ZqOrUzRDDuap8tEkfN7zrRdUBXUhZBIr2YubKV9rC/36gzXo/qP0Rp0IKcMq2jCtVIO4pDvk9yy3WIyhixGwbkkb1nbVkL6iWrLfH16kQLaKeHJ6q2fnsTrxqybdStotF14AULUYyGXdMqi1PblUNPX6ziJsVASdEbDm2+6sCKh0r5opqgq8Qy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:6vNRP5QAEvqZ0Upr4xVoQ3r/iL1Zczq0/qiXoEK2qoeexkNLbCICqcO3foNPy62GPuyOCf3KBn+WK3kHrUbkfe0UojEnw9IB7Tbig4r+KjuNokGmLJqcmbxL8Jh8NLzR/jwi+n+iLpYWn8uGeVeTVC4OXlP5DVh5/ZjYiOIDyz8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 14:50:00.6514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d261fee9-eabd-4091-4181-08d5f6f4e6c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 04:05 PM, Andrey Konovalov wrote:
> On Wed, Jul 25, 2018 at 3:44 PM, Vincenzo Frascino@Foss
> <vincenzo.frascino@arm.com> wrote:
>> On 06/26/2018 02:15 PM, Andrey Konovalov wrote:
>>
>>> @@ -325,18 +341,41 @@ void kasan_init_slab_obj(struct kmem_cache *cache,
>>> const void *object)
>>>     void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t
>>> flags)
>>>   {
>>> -       return kasan_kmalloc(cache, object, cache->object_size, flags);
>>> +       object = kasan_kmalloc(cache, object, cache->object_size, flags);
>>> +       if (IS_ENABLED(CONFIG_KASAN_HW) && unlikely(cache->ctor)) {
>>> +               /*
>>> +                * Cache constructor might use object's pointer value to
>>> +                * initialize some of its fields.
>>> +                */
>>> +               cache->ctor(object);
>>>
>> This seams breaking the kmem_cache_create() contract: "The @ctor is run when
>> new pages are allocated by the cache."
>> (https://elixir.bootlin.com/linux/v3.7/source/mm/slab_common.c#L83)
>>
>> Since there might be preexisting code relying on it, this could lead to
>> global side effects. Did you verify that this is not the case?
>>
>> Another concern is performance related if we consider this solution suitable
>> for "near-production", since with the current implementation you call the
>> ctor (where present) on an object multiple times and this ends up memsetting
>> and repopulating the memory every time (i.e. inode.c: inode_init_once). Do
>> you know what is the performance impact?
> 
> We can assign tags to objects with constructors when a slab is
> allocated and call constructors once as usual. The downside is that
> such object would always have the same tag when it is reallocated, so
> we won't catch use-after-frees. 

Actually you should do this for SLAB_TYPESAFE_BY_RCU slabs. Usually they are with ->ctors but there
are few without constructors.
We can't reinitialize or even retag them. The latter will definitely cause false-positive use-after-free reports.

As for non-SLAB_TYPESAFE_BY_RCU caches with constructors, it's probably ok to reinitialize and retag such objects.
I don't see how could any code rely on the current ->ctor() behavior in non-SLAB_TYPESAFE_BY_RCU case,
unless it does something extremely stupid or weird.
But let's not do it now. If you care, you cand do it later, with a separate patch, so we could just revert
it if anything goes wrong.


