Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F57AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036AC21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X4k2EHSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036AC21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbeHBQTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:19:03 -0400
Received: from mail-eopbgr20137.outbound.protection.outlook.com ([40.107.2.137]:40800
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732202AbeHBQTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jni2ThDJ1PFt1H7PNbjn01Jk/dhui+/6epVJ9rhIrM0=;
 b=X4k2EHSsrSSAeUao4DKdJNgzf+w3lN+rQ2hsT/ypFvBnPRJflYr4ab/k4TxPj+m36dFmRyM0EolhqgQM4MbuT8Gy95uqUkk+NungIgB6CQ68zNEBQf7OBUX6r8HGyh7FASz31YEF/Yuhhjo4CUxcbKEe1uKPGdb4MEaIFaxBECc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 14:11:18 +0000
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Lawrence <paullawrence@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-sparse@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
References: <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com>
 <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com>
 <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
 <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com>
 <20180801163538.GA10800@arm.com>
 <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
 <20180802111031.yx3x6y5d5q6drq52@armageddon.cambridge.arm.com>
 <CACT4Y+b0gkSQHUG67MbYZUTA_aZWs7EmJ2eUzOEPWdt9==ysdg@mail.gmail.com>
 <20180802135201.qjweapbskllthvhu@armageddon.cambridge.arm.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <da873a0d-3c75-0a00-974e-824f1eb49de6@virtuozzo.com>
Date:   Thu, 2 Aug 2018 17:11:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802135201.qjweapbskllthvhu@armageddon.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edfd0648-31a3-43d5-519b-08d5f881d30a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:20FV5SLLeYOo4SCDjL3rYqUpWq8SuduyIGLp8uqYIoV53RwiZIn5STcxWF0bIBlmiKBbNb9mN56NPvQER+rMcRthIIIv76pZX331TFf3IhcTNM0SgKeOOip4t+KKCsh+1xHooyMsyrH7nGL2kbT3VPCzgUP9OzshIsVJwjHK3p3OFWYgLk6V7+6u+RV7YnYydtCTTSZebK6vBwoGcGfCeZr1mMGwb5+G4D23TfpN1B9Az1EDMkjKF1T4oM2kqwC/;25:83hck31u+QdpaUNn4LwF00M9Mx4bkBKO5fhyPLVmlNAPAYuUBq/JLKe0DSkwgRh9hqUv1V0++bSNqlyE8Q9dV2a/4JSyMLFVywNE0qUzICss1/Rabe02daBVwlk2ntcUtNNL3gJ82guvhq//Mi3CXp1sP4BSsHRHa+CuIojsnvJAIC3Lqe1Z2V9L2kE+c06/HpBHriZatolDrDsdk8IATeKEeit9jxgTw0WgTNXqeEjtotaraC+gY9nCUjGXDoPgCgHsY+WHUwTo4Lx6aTuySSPJv5efyaDLbU40JyaPgr6yw4ub6N+8YM1Cgeio56osQ8+4lj2y/E7bmzNXmWmnNg==;31:d1Ts6neheD1gRWuO3frptSGzLbg8StygJ4WOYrAu+OqIm/4+owbV+O4meAMz2ChXnLgneS153dgR8Pm3XSzURqP8C/a8z28FvtH+5L01sY3Qtt05CojaL/Q1vuYVZo0Bj2thkw1ZjNoI63I/AvWcp/lGtwE9dZTB2OiTD/bqTjdUbpuyysA+u5Nx4hBotZn5gFoZNSKSlH6PZjqK6NmPzKZlb4LUVQvdIKF9YXHdths=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:xAYhMoxPCeDSTF7vumiFeaWqbfs5MnkYY/eKJnYXcWtrMzF9y3kyyVzEkqzdZirWZQFnRhNHfFr36nvNGuemphUBY0sOxWa9RQ8EmBEs3uOHZ0gX1DMM4yQrWekkwBOwSXudOBnevzd+z58XmF6ZbebeVd4LK07cyjorO0d0PCQ4kwOUs5Vv9gFurOnbC6aznc4hS1RxV0uaj76k3bu6Uctii2JG1TecM/PMQQ7JvYY+AKWrAW9J2qnttLoJZoX91jRrGakW06jGi2dROBhf4mA9MC47ORRNTrVsIBRG+ugfIMCoEtBT4P/dfgr6/waZhTmGxSMwSEcXRGQRXVSqE+WOWmusLFNBm0WWUbTaARbLRo156OTq19zEM7pvnTUqkJ3b6BuwA+OeyCsQ6kmAPyvz4Kit+0hds/CPnKb8RtvxeHE6hI/3lX8/QkmhD98Q1EKFU0p2kvWuBUnrbtXjle8f5g9+PAUk0yY2GyF+776y3izP+Tx8Wymvke8YxkW+;4:tYkD1+trxuOsGnhVbXgcSde318X4TYOpzgs4KN1UXkB/3u0+lWp3JZjt4jJptAsm2mRAUwjv73VxUy4vEAPq/9OteIwWT+aEsTXAJjXc5YMpkqxR2tI/O4UQuyLDPtC54HDEmCikx9e6oSx3XCTujBkRVIWtONX3mamRQcaOL2c9y7QdfCuk7pDMZnNtK9AVnyAS8z1JM7kPzwiN+BMOxyrETeZnlZBxIXAL2S1TkGnNQxJein4sMVc793dyw65LzZeRY+jRW6XG8h+iy22wvg==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3258D7B988F30E14718B9329B02C0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39840400004)(346002)(366004)(136003)(376002)(189003)(199004)(956004)(4326008)(8676002)(81156014)(86362001)(93886005)(230700001)(47776003)(77096007)(81166006)(53546011)(386003)(53936002)(64126003)(7416002)(5660300001)(486006)(186003)(7406005)(16526019)(478600001)(2616005)(31696002)(6116002)(476003)(2906002)(65826007)(26005)(3846002)(52116002)(31686004)(50466002)(23676004)(2486003)(11346002)(68736007)(97736004)(16576012)(36756003)(76176011)(52146003)(446003)(7736002)(65956001)(66066001)(305945005)(106356001)(229853002)(6486002)(25786009)(6246003)(14444005)(65806001)(316002)(110136005)(8936002)(105586002)(58126008)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOnd5QlZFZUxSRm0xZWJBRHo1U1JVOW9RQ1J1?=
 =?utf-8?B?NDJwRGNpemZYU084Zkt6TW9aSXpqTVdPclNSV1UvbUxFOGlGeG1kaGYxSWc0?=
 =?utf-8?B?RFdnZVphRVBpRnQ4elNJaFcyUWw1eCt3OEdWakh3ZkFnRkhSblExSmQrVTMv?=
 =?utf-8?B?TGp1Ymw3ekhnMGhDSUUzU2doUms0eGFZMm15c0F4TWZNZmIxTmNvdzhJYlAx?=
 =?utf-8?B?RmxVVUlQdHQ2cXBMNXhORkxjVjJXMm1jYnhUNWV3ZnZVL3FVMmZXZGROYjB1?=
 =?utf-8?B?U1d4dDF5SlBhemFkMDRQY1dBV3lueEhkT2NhSUZIQi94NFd6cUUvZnptQ3Ix?=
 =?utf-8?B?TUFyWUE2SUtNaHlaOXY3UTVCTy9sWGVQV0cycjQwbVBISThkSHN0NGtreWg2?=
 =?utf-8?B?N0N2czVzSVNXVXYxdFg0UTZHaC80OTNkaEZNS2lLTk4rQURvNG93TkhPbmFz?=
 =?utf-8?B?UjZkSmovTmk1NFBYaU12OVo0b2dJM1ZpUjFJeWw4RDhqL1NOdldVbnQrVk5X?=
 =?utf-8?B?YW5CbFZ0VTRIK25WNGJKRkx2NXpFUVZMR2FqYjB0MG1iVzJJUU10Ynl4dmg1?=
 =?utf-8?B?dTZoUWhBWmY4WVFxdDFPbFl5Zk90QVYxNk9ZOVEvblI5WGhWT3lXV1M0QXhy?=
 =?utf-8?B?YjZHU3d2YkozaTVpQVJVNmIveHFoM3pQL2VNdW0xb3NTb1BRUXpCTUlwTmQ3?=
 =?utf-8?B?NEMxWWNySkdkOVFCa2lpMEFmL3dPRjI5cy9RWTFlY3QzcmtmRm41UnR3c1Yz?=
 =?utf-8?B?OTBiV2J3dHN1OWNKU0JIVmJEV3d0Z0NCbEJWMWNKVzcwNTlnYWUvUkdLa2pt?=
 =?utf-8?B?MGFjZit0UE1YOW5nUlRZckhnRjVIbnJRYklMY2ZvSjIzcGVWOXNoQmIxd3VX?=
 =?utf-8?B?blVVUlFqd3NOMHdubHdwZ2xMN2FJNWYya1FUTmtBV1FRcEVMQk1CdU1QcFE1?=
 =?utf-8?B?L29ZZ1IyQjNsS3Bwc1RaUVdzdGFiQzU2b0tDdWxSdy9TU0grTFMySnU3SGFI?=
 =?utf-8?B?Z1JJVHpkNkZHNFgxKzc2dVdMMUU2N3NKNFlwZTc2cTRZU1g5bk94UzB6TFEy?=
 =?utf-8?B?OWdqUXVDTmdJejk3bjUrVjhTRzZTTTM2eVJCaE51MC9xTUo0M2pJZ3dqT2pD?=
 =?utf-8?B?ZG01UXJSSHpXZjFZRmpKdllYRUVWOEpoMHV2eXc0MFZVRFZ6VDl3ZHBDQ1A0?=
 =?utf-8?B?L2NNVmoyZEhKUlNuV0JGQkQ5Szkrb3RUdnBiRFZNcVdFbnJkS2E1V24vcjZR?=
 =?utf-8?B?WUc2S2ZVTnJlMVlhNGVscGJ0UzhLcE84UmdKWXgyWFA0c2dJZGxWdnhTZitt?=
 =?utf-8?B?WkxXZmpORVJMTWE1L2JsRS8yRjQ3d2UzS1NUUndsZGppMDZBSU9NeFI4WE41?=
 =?utf-8?B?a2Rwc3Z3K2ZYSk0zMzIzR3ZaMy9WNUllSmZvamRiT1gwOG51NnBjNUFZY29u?=
 =?utf-8?B?U28xaDkrbG4rR2Qyc3NZc3I4SGZkUVZoeFFiam52dnhUQjMvblFBalNRZDI2?=
 =?utf-8?B?Q0QxaDlmZ2ZQbzhNTGcyUjZLVjRBMlBaaENDNEwvQVQrbXZhT1ZMc0trSHpZ?=
 =?utf-8?B?ek9NNE9ualc3a0QySlNtNEtuMFZieWN0aWxsRkNWWmNDWVg1V2FmMkNTbE5Z?=
 =?utf-8?B?Y0sxWHFqQ2pzaGd0ZjErYU4zVnNaK2N2cG5ueU1BZk40eFJLSUdNNnlYTEJr?=
 =?utf-8?B?ZmhyZjR4T3k4eU5iL1JpNjc4SVRGZDhwaUxJNndXVTRGaERDYmpmRlR3SHh2?=
 =?utf-8?B?eldHV3dpQkdTempUcERVNjRLNFhkRVhtVFY1eXA3eHhsYkc3QlJaa1FrNFhv?=
 =?utf-8?B?RjNnK2FPVzJsNzdkR001Um9tTnNCU1hKUExhb1haZGpRTHNGeHdGUkNqR2Z6?=
 =?utf-8?B?c25yTHlSc0dIdHp6a1U2UFFLdThKaFNtdlZDZ0M4YVJuZWtQTWdyNmJTUzlE?=
 =?utf-8?B?M0JJSVlrNGNjZTkwRVlwbUorcFhqeUx6U2xFU2ZKWWlZM0NBSW9hVnpydVkw?=
 =?utf-8?B?NzhGOHllMUJsRjF5Mmp0OGtHVzBrTXJWTHVBUT09?=
X-Microsoft-Antispam-Message-Info: RVL7Y4ZHXYe1dBvu2r0m4k/uCcRxKbOAFslRCoeJuC+Q7pAQXBy5rpmyUtiuNxH+aRlbL8pew70v5eYwhRQ6OvcREeemc+08cucF2p2aHvh3+G8b8y8PThvg3E4+uhFhNlAN9E72BZfHxnQ42zvULZ2oErO2HwSvh1eoDlGiKB1UyL92OqMtXSdywpfTOGBqFkrBMfs/sbKVmohiDE7K4Dpf7vIQ53LPAOjrnP+1h7moCBBcsHqfOWOD0IRPoSraW3sLJGQcu6Vfa4FBcxauPr3ZhZSqTXRhKRZ46n2oAdra1DFoBJZph2ZTOc45JObWKsPoONVSjTEXqqHBqLGu6/IbAmU19pK5a3Ajx+lN5Bg=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:HkSKDJyHLtiuxtCf1neELxKk5mH2iISW7Ufhby16pMDgsrFgzxX6odqET2l9bE6Ieb6M/yGmF9/QVvh6n4q+8d3fa3G538+hntCslu6Ofid28POBq3KYkWott6ELci8QZ860UP3BT0PnbgGk7MrFuMLVY1+fIp0DKgEt3uR2Z+8sucNKvfMDnK1qOdmNK1158FAwXPwGIosKs2lYTTAeq/9C6qqg0BPz1OxI3wp3geFI44wLgk549vRNRiVdMexQKo0109KFi8P9v/sKwr1lSKsav3t4YRzmsFRus0kjdvIR43yEYOIiGl3IjRrldWfoPUwMFSW3cLGbuo6iYXtzmKR0aM13B5Yl9bKZwvPOc1aEcXMHlhR22spnD2wCrLY8B4WmuI0b9npurIQ2w6mQUW2IB+EAasSeEGprXLkgnwQsL35HaxO5bDOCsl/u+cYFdubBnpDqyqeN9HCgtxkMiQ==;5:Xg5kDtuM5asamFEtEqk9m8pDrxllUCegwl0rqKSwlH49EIoJ8TbXNtMtJxSsLQhkl7fRPchhXATRi25pS4h+C2rEJB2dSOCp0asXRBX6HcMezhMFeodHL5goARk8SgYlJNdgmgon//3VNuXZu+WWjww4WoSPAbUsGWK+sm/MEIE=;7:7DqHOChcwQRX3Hx4Z0S75SO2rNSv/It46LEBTHhAaF6LURS25iv+D8k79PrtvKHMBuuYt7dU0wnZcXLs9JFiJFjxPQWn68dQW8V7jA4ARSjBEm/ugST1byaYazY5ZZja0gvQxAmTPmFLryXfCJWzBeQsc22LVexvIRFJR/kTNTgsUIBO6qbNmMtVF+E5uY/T9gnSq1ZqSDUz8wonOMs2nE8CeQvMRAnwMxJ4HEDULwEAeoDQAgj84Tb7OEcE9ErT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:f6nncq8DBn3pW1oczRteaNxbBQR8Hn21z2u14/b2yF4JQ9SZuLjOgro1pJk5d5JqoMllJKEZNZitEeXhbWNx0QqPvvuGK2S5IBxPBKCZHs5owcDVdQycCLDZultUB1Yg3YqYWug53wOMh5oEZ4OYoRPS7ot3335/dkpmPEPRp9I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 14:11:18.0705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfd0648-31a3-43d5-519b-08d5f881d30a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 04:52 PM, Catalin Marinas wrote:
> 
>> If somebody has a practical idea how to detect these statically, let's
>> do it. Otherwise let's go with the traditional solution to this --
>> dynamic testing. The patch series show that the problem is not a
>> disaster and we won't need to change just every line of kernel code.
> 
> It's indeed not a disaster but we had to do this exercise to find out
> whether there are better ways of detecting where untagging is necessary.
> 
> If you want to enable khwasan in "production" and since enabling it
> could potentially change the behaviour of existing code paths, the
> run-time validation space doubles as we'd need to get the same code
> coverage with and without the feature being enabled. I wouldn't say it's
> a blocker for khwasan, more like something to be aware of.
> 
> The awareness is a bit of a problem as the normal programmer would have
> to pay more attention to conversions between pointer and long. Given
> that this is an arm64-only feature, we have a risk of khwasan-triggered
> bugs being introduced in generic code in the future (hence the
> suggestion of some static checker, if possible).
 
I don't see how we can implement such checker. There is no simple rule which defines when we need
to remove the tag and when we can leave it in place.
The cast to long have nothing to do with the need to remove the tag. If pointers compared for sorting objects,
or lock ordering, than having tags is fine and it doesn't matter whether pointers compared as 'unsigned long'
or as 'void *'.
If developer needs to check whether the pointer is in linear mapping, than tag has to be removed.
But again, it doesn't matter if pointer is 'unsigned long' or 'void *'. Either way, the tag has to go away.
