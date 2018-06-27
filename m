Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B19C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2D126010
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ToSu+m8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2D126010
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeF0PIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:08:21 -0400
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:4398
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752437AbeF0PIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpyBq/gFWWWywlWXAUuqvIVSyX+NV0igGNwzWTktnsA=;
 b=ToSu+m8DDRiF2nUCYT4G7US027b9hOVOcHwoCvyWb4NP/4Cug1gPjkxxIk9LBkhP/VehDm0s3NjuRWOzMSmk4Sa7Cy4xGpEUeLr+L/RF4seaRD/Zx7Rn5/PlyaycHHiXGsC0gkMbCP4myEnp4lFRqzummKXwlJAv/QE1VdB1E6k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ramana.Radhakrishnan@arm.com; 
Received: from [10.2.206.71] (217.140.96.140) by
 AM4PR08MB2788.eurprd08.prod.outlook.com (2603:10a6:205:d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Wed, 27 Jun 2018 15:08:12 +0000
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Cc:     Will Deacon <Will.Deacon@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>, nd <nd@arm.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
From:   Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Message-ID: <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
Date:   Wed, 27 Jun 2018 16:08:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: AM0PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::40) To AM4PR08MB2788.eurprd08.prod.outlook.com
 (2603:10a6:205:d::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf2e6d48-6360-49f2-c7dc-08d5dc3fcd86
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB2788;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2788;3:+8Sd4HV2Ikj4tAZkSBkmSh3YFDncmAkUsunb5L0UfcciRJokkvb4Z/U8/zE+re+a82lbswvK8s5NAcFXAutchvXh+NP8Gqkz3YAO8ZKykRnyoV/4rTmmu9nYOTPVoIqYVNAIXCry2giJLGqepbzSqzxe/zNr1RnE9VQ9/g8c2V1JPPxjbN21K8m2gIVY23PYMaOpq15M8yLXiMLH8PBixYbv/ENfei0eKJG6htjMTZl1fayinJ/vFSTZ7U+neoMR;25:BjIt6DlRDAQ+3ZeB4Jv99suqkVZ9b5abawYbO+c9ms9cSMDYUmi1fOtO3KRmHrC5GxQ7p+oAgu0N0IhaB9iwrrylhzhiLZTxrFt0J25I/JjvFvwbp6/MLpH3fAtv6KpfzQZcJ0BrQtCmgEd+TCGyTspy+gf9Wsaibg9sDoDJKe39I1C1j0IeIxUnbZ4LodJiG6k0157bcf/S2cyQ9eMugAvyNbztgKDcppwxdEbp/rW5ior2SVfTcgdpHfekm+zRUPmpCvDMhtGnWh6tTVBdyj6/sSk3lo9M/yJoZNSraHj44BP+r7wY7PVwDBNOHNfx+HXCyXhJdFRen/RSXknGgg==;31:JYbNZ0e0gSNZSu9ZMWb2iSnMpBv2SDwzxLuzEsa/Iz3XHPg0QF1vm2FX+B+Gb5F4YHYz9/6jJ2z5N3EFNRuAD7lVKL+4DqY/QlGOQsCF0R2Fc6MVLihdqqfykKvKACj1rzq3qdJW8mV1edC43jdSNvd4ckLf+2vcER3MVHPve0MLuYV+WfH21+vMp8bq0f0UnOPIKMpltmSfypIdqk0G3XCYBVLPAoGf6GdYIaVdE2s=
X-MS-TrafficTypeDiagnostic: AM4PR08MB2788:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2788;20:Vc0lVeysoniAvmqJIHhA4zoT0lMZqh6rJdQiP2piYjSNfoMXt71nVdAGBVkQdvXZyTSbdLpvQF/8G1vKU6BpxQ8Aps5ch28Ma+xn8Cof7Nq8DbNVANIvryFMI64tlG2V04Bi9CKTuIfI/UNNUJD9EGOCOtmWxTeNlQtMFZ3YiiQ=;4:Hkh1fZv0izbYbaK9chQyyubSfMgJKyv4ExinsxgVqYduTtqArtqB32ERPP0af78A8kSNPAYTfpV9F/voO7lqpE5Rn7wf3AhQnCwOd8HktrqO4W5yYOX8P7qMJDRClzljgxtB53hZ7++CdLnQDKeovRqDqobjicnmTx2FZ1jOIAoOHCchzMO5X4MAArX6s+hylDnC8AChQMMC3touhrPNO7/edmNh0upbRa0A2+KuSKxAvHltwll2570xxlRFyRb8eORqfsn08njvrsksJwJLn0w0w2sI9ZrZOHDQe8v7Wt4edcX7O7clxqqXuif4xjCgpJHgAtc/PmvGws9tUZgx7plwoJfKuRmGDmpxRvddf/dpOFhqcS4Q/scdzX21mc/YDLFjlj+9mD3c+RD43DTzXbbsEqeWIj6xgD+XyFVK63k=
X-Microsoft-Antispam-PRVS: <AM4PR08MB278815F44BDFD40DA9E045CC81480@AM4PR08MB2788.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(262104967686372)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM4PR08MB2788;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2788;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(199004)(386003)(72206003)(58126008)(68736007)(36756003)(8676002)(25786009)(81156014)(52116002)(2906002)(54906003)(6636002)(16576012)(8936002)(4326008)(316002)(305945005)(7736002)(93886005)(230700001)(50466002)(64126003)(6246003)(110136005)(31686004)(6666003)(81166006)(105586002)(106356001)(97736004)(3846002)(6116002)(53936002)(47776003)(26005)(23676004)(7416002)(65826007)(2486003)(65806001)(6306002)(5660300001)(66066001)(229853002)(11346002)(52146003)(53546011)(486006)(476003)(6486002)(86362001)(44832011)(446003)(65956001)(956004)(31696002)(77096007)(966005)(2616005)(478600001)(76176011)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2788;H:[10.2.206.71];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA4TUIyNzg4OzIzOlFDL1ZIbkhxS0J0N0JLTDhpV3RXSGpMZTF4?=
 =?utf-8?B?M3I1RE1XQm8rWVBSL2MyaGpHeDE0TDRQU3oxa202S3hIZ1ZwRCtOWmxBVTRO?=
 =?utf-8?B?NmJoNnNDNFk1UzdrZzhmaUVBRGZQQUxDS1dtaERkMGtXakFGQWNNMkFzWEE1?=
 =?utf-8?B?RzJuNUtlQlh1TlZMaGRRekFLRC9lbUp4UkFsQlQzSGZYa2tTUXAvMXFPWTFu?=
 =?utf-8?B?c2NROFZOR1hiSDRXNmhGS3BNbU9ZVitRSGdieDM5MjhqOStwbG1SVlM4Y004?=
 =?utf-8?B?VFlmMCtSVk9aQlpYRlZ4cGI4MSt1U1RuN3JUTlNhZTNCUTQrVW1jZ1JyMlEy?=
 =?utf-8?B?TTcwNzVsUDc0K2FmY3AxbFFqbklXMWovYUhoV0dhUFRhb0k0UUdGQUNFWHYv?=
 =?utf-8?B?L0tkZE9URk03cGV4SGdoS3hNb045T3NTYmNnck9rckFSNTBpU0E4TlBkMEQ2?=
 =?utf-8?B?aXhoZ2dVSWZBNXpIN1QrVlU1UmplY1BvbXpjYVY4aGpCT2tUUDFnWlVxV0E0?=
 =?utf-8?B?YTk2ZURNOTA3Uk9VSytaSjdDYWxubzJDV3JQL3IxNVVqUzgxNTV1U1ljblpU?=
 =?utf-8?B?UVZ6VjJ1SzUyZDdlUlpLb2FsR0VvQlhZcUJJYXk2S1VHZFNNZ21zazBkdVQv?=
 =?utf-8?B?YndQV3BLajNoQkx2WHZlN3lnK09WOGFFdHV4ZTYzVnZzbHMvNEY1cS9KeXRN?=
 =?utf-8?B?Zkt1c0t5NVZKZzdhM3kvQzF3WDJTdFZBcnNEZWRZOTNHRkRoWDE2NmxqRm1G?=
 =?utf-8?B?WGluYk0yZzdRUjlXQTk2ZnNWbVFEWGRyUjRGRkRWejhWY3F1TnhXYXByWCt2?=
 =?utf-8?B?TUl1cklUamVBZys4UTI5NHNSUGc3YXNJS01oUUQrQVdzQ3R6YmlPdGdpaXJs?=
 =?utf-8?B?NSsvRU9ZU0hBUlFqRGVvd1pEb0lRV2pjZkdhWEJnU3Z3N3kvMnhuSVRSWkRl?=
 =?utf-8?B?TmV6b21YOG9YRWUza1Rhay9xekg0ZmdVOXlFUTZxa2duZG9rYjRJbDh1QmFY?=
 =?utf-8?B?L0lHdWVUV3ZZeFhzL21DWVZ6Z001NW15Tm10aEpyM3ZHL3AveHdnZTh1anFp?=
 =?utf-8?B?NXIvMkpHc0ZHRjB3RXZycG1PUUM4T3BMZjBuVVM0WEFRNVdKREhZQUVjQlNu?=
 =?utf-8?B?Y09CSUk2VnJTcEFhYUg4UTF5NVE4enZRc3E1M3dBM0toemFhRlhrdGtoVnV6?=
 =?utf-8?B?d2dVZ2toYmJqaTlzYUZ4blgyaHJ3UTlsckgrZDI2dDAvb2Yvam9MbWsyL1Ny?=
 =?utf-8?B?NHRIZTlyYXJjTVRkdHpXaXJiWTNjbm5GTVJBdWJDOC9wTHU5a3JoWHNIbU5W?=
 =?utf-8?B?QlFoaGVrK1lGOUpWNlMzeU9HaFZuSmtUU0NlTDF1NjJmalZwM0F2OUFCTFNS?=
 =?utf-8?B?YjUzbFpIWURWZ1JWVG96NG4zL2l4OG5MTjVsUWM5NXd4dVVoOWxORmZPcjBk?=
 =?utf-8?B?S0hJZ2xSM1JIeC91elhVVGNQZzRNNDVxNWk5dS94dEhpNGNuWENSRXVNdlFP?=
 =?utf-8?B?L1RUbzJPSXlXZDd6aDdFK29RVTdRaytWU1RDMUZzOTNrNjVLRVNRdjhSWWJN?=
 =?utf-8?B?K2M3cDYyekJuWUROV2lMaHIyWUtZalA1NnVBZDZDN2xJNVY4SUlTRi9admRz?=
 =?utf-8?B?U2I4L3RpUmRKUUp1MW5jeDcyQ1l0cFJha0NrcjF6aG9YaG5pR0xwWkxDNjlH?=
 =?utf-8?B?SENFVy9jVENkRUZ5VCsvUXNhM2RPS2EweUxsdXQ2blYrSkUxa1BaR0M0cmpu?=
 =?utf-8?B?UVBJbU1qU3lPWjBOVGhhQWJlY3FleHNWd05lYnpBS3NHQ3dtNUVPNWlEeGlL?=
 =?utf-8?B?WWZzaXAvSjhvSi8zYzgwZWdOT25kcVlLSnhaNHFMYnJrdUsrYnpxWW9VeE10?=
 =?utf-8?B?UU5mQW50RGNVYW9LOHlOL1RDVEpRMzFuWWhmOUIrSGh4dEpBOWpkU0c3K01o?=
 =?utf-8?B?QjhNLzhvMk5FUUdNWGVWd21UOWVzcXV1MUdUYllHaTVNa0d1ZmdGdVY3NU90?=
 =?utf-8?B?bnByejFqWWlyZWtleXdOTCttRysvamxYYXhKUXF5cDYzZ2VXNGQrZjFvekxE?=
 =?utf-8?B?YkIrdmxtMEd5ZjhqYmtucWxZajNuQjRQVTE0c3JOUVVlN3cvNzg5VmdYMXV5?=
 =?utf-8?B?dFE9PQ==?=
X-Microsoft-Antispam-Message-Info: 836fadnHJYYHK0O0hl6PytsHXQpwnKZqOC222+mpCIgCd2HrTzJ2XEpdqc1GOKm5luI94oprZdC/2DXwgzQlKU/5W6K4g21IllFrzVcvGBL7kpcFmkj58XL3XvTM4+AVs0NPIO/DSGvOBI4v+PRy9udPgCq+e1NqAV4VFsN/MeMZDBYzJJxU/WZPjfYYJAKOpNYQxPvMRwFGMzZRANNr3K9aUooQAIE7iBrKlEYFUltg6430KL4hLuLEEWXQwxTEyEcEyUpe1nIMwFJgDkOxvcqsrnwnPPIF+eb/o4lZmz0LVMkLfvm3QS+txuMbDZ5fhdv3iBJWj8f+zhEVVJXQFVXKikZJu+etssGKLMCFDA4=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2788;6:LqiH+m3o1Qa3pta27riiQI0A9FUt1LIz8gzEi8e4xeoIzLwGhQeWOivGmDnQ3p7FNTyWGMsoFTZw9lmjjn+JP9+CAWRZofY3HCi7FULzLR6PurSrqvXN+cwhFZTaaWgNVH6jWYrqs/HIKZFiHH+k73tqDokRAs7jGC2aZf+4aoiu5rCPGc+oy1RigqUf9CiaMZHcTUxRH1djBaT7FvBjya89MpsoFGXzuP2rDSg+EzCK4GIC2ldkS9Fv2/TYMTLoh0SRVBfh835sqwKBYatk+RGzu2jiVUfOTUq8XcOGg8gWaliztjHpy/2BWZJQUW4TuAUcLnmikCJ+ZTCULNZ/mDWTa3QrQua7HmY4xcrzCK7bXy77V6TjvavlaTWbIDZyPvSXEdau79tAmQ7BwrQhu0u2QfYLzYTN+zL5pq19+xjKlYs3R+hZ9ZqLga4LlcUaoxKMSn2U1j0L+MMGdmtMvA==;5:NtzsiSGf0CnKETJIUv8c46B58QgwkccXm+Zhw7Kz5UhD8rDUnPK0UIElwEpw4d2mBjDTB/KnK/4aunZqzRGGNcdSmU6+ljWuhVBN0vpVSiVZvo4MSRBvWrGlCsgDZnv96iFXIR3WUh7EQ5Q7qPY1h5lAdgUraKGhlUP7w/F3yv8=;24:L8/lQKjJdO8VHp6I67eRpr9MAgiF6CXqOtkd/fh3FFlLxSMHc97IAlYoeLy3+kj/oEmIcXOsLiiEocskhdk+I71OQ6Q7gKYjrrRBp+QtABc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2788;7:a9YGl4yhoQy4awJgDHZOGSwqN9gXfUgha7+K1RI4tA8OYchk/8arNEH6HvXYOuHwpycMRY32BZJnOvNB64HLU2NvpMcZ4jg3/CB7l5+4qe04YkyuBPiTMLal1ocWk2ugug/oPHHnS7xp13mic1761umx/nKavVOXzIWFLGjtqpy4UiZQiuRvweO8oS4RAb7eC8FYtjYiGV3F6xyI0hjpvDtQIdYcOPFZoAHEX2hdZw83isQmsJHawvarYS8ivq66
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 15:08:12.1949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2e6d48-6360-49f2-c7dc-08d5dc3fcd86
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2018 16:05, Andrey Konovalov wrote:
> On Tue, Jun 26, 2018 at 7:29 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> Hi Andrey,
>>
>> On Tue, Jun 26, 2018 at 02:47:50PM +0200, Andrey Konovalov wrote:
>>> On Wed, Jun 20, 2018 at 5:24 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>>>> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
>>>> tags into the top byte of each pointer. Userspace programs (such as
>>>> HWASan, a memory debugging tool [1]) might use this feature and pass
>>>> tagged user pointers to the kernel through syscalls or other interfaces.
>>>>
>>>> This patch makes a few of the kernel interfaces accept tagged user
>>>> pointers. The kernel is already able to handle user faults with tagged
>>>> pointers and has the untagged_addr macro, which this patchset reuses.
>>>>
>>>> We're not trying to cover all possible ways the kernel accepts user
>>>> pointers in one patchset, so this one should be considered as a start.
>>>>
>>>> Thanks!
>>>>
>>>> [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
>>>
>>> Is there anything I should do to move forward with this?
>>>
>>> I've received zero replies to this patch set (v3 and v4) over the last
>>> month.
>>
>> The patches in this series look fine but my concern is that they are not
>> sufficient and we don't have (yet?) a way to identify where such
>> annotations are required. You even say in patch 6 that this is "some
>> initial work for supporting non-zero address tags passed to the kernel".
>> Unfortunately, merging (or relaxing) an ABI without a clear picture is
>> not really feasible.
>>
>> While I support this work, as a maintainer I'd like to understand
>> whether we'd be in a continuous chase of ABI breaks with every kernel
>> release or we have a better way to identify potential issues. Is there
>> any way to statically analyse conversions from __user ptr to long for
>> example? Or, could we get the compiler to do this for us?
> 
> 
> OK, got it, I'll try to figure out a way to find these conversions.


This sounds like the kind of thing we should be able to get sparse to do
already, no ? It's been many years since I last looked at it but I
thought sparse was the tool of choice in the kernel to do this kind of
checking.

regards
Ramana



> 
> Thanks!
> 

