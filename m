Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1E8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F742083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RaG6ON3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F742083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeIGUvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:51:50 -0400
Received: from mail-db5eur01on0118.outbound.protection.outlook.com ([104.47.2.118]:10816
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbeIGUvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpYeK8kLA4alwQ4ru+SKrH4NAiIAgAvyqAj+OfdZw0c=;
 b=RaG6ON3R9HcmL8lyu1DeXq/QxAO+QBO75Nv1i4UkER3dV9eQh5qKRwYcyPQq2AnkOZHakurkOo2gaZe4LigjEvUsHC4UuevyyrJKpSBTYJvRYrwxdyPtzNIoWPstrTtISOBIGJdz7hiHv69AyoEYSClDqfzmW22m8PWyl4g9qyM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM0PR08MB3250.eurprd08.prod.outlook.com (2603:10a6:208:5e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 16:10:03 +0000
Subject: Re: [PATCH v6 00/18] khwasan: kernel hardware assisted address
 sanitizer
To:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
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
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <8fb4852e-a88e-2d3b-88ba-4b73ac2c890d@virtuozzo.com>
Date:   Fri, 7 Sep 2018 19:10:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P18901CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::24) To AM0PR08MB3250.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0064547-3e65-4018-03cd-08d614dc606b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3250;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;3:CDhF63w6RgvjtYSJh2rlzMwVP50DRMWUGqhmJqaREU2LsIXKRUCQh6bNV3Bti9Z4UzJNxeugEuRfOLaKZgW+zu9kbaWKNAo/bEyOakUCji157BBgDTy6t3BB16nPpCge8plBrfEA0ufQrhaI2w5GAtek8yW1H7KENdUmVpcmC4vmJhtRhhQ21J4+4yRrfjrEcrXoRPWAlJpJ3XI8Mgh2vQgniyh8ipUJfjAZOAgm6MnwC9sbGSmlcBFZ/DLj+xP6;25:a9dZaLsw6hVzFKE0yhUKBSHYbRchkvifLZDrFE79svS4ogOshBJFqeNXGkXMTaM+Q2My6h4YZm20obXwafnCXS6SNlTHM1K59gOWKT1p8FTqNAdDKA11qMxoS/K2ECCSiXAMKY/3K48B9gvjHoh/Fw5zBFHPBZ1BlmkaE69Wo4RZ65pqFJCPf/kSerbS/AzaDM8AzJL4M7ZS7GD+BNeOdw04Lz8hLJiNnLpzDq3Oesh43JaO1Muk6jfbTUSTNIbBROOPNL6221zrdNgB0/RT66Ow8d7BAvPSduVNWAus1lbxDu4Brr9mvsJyNzpVD9bJv1I1/Wbke7grq+ESaioB/w==;31:rcGDQRpB+Kofex9uUP4UNqw9SMZ0b03aqzKRV0ybmlpVmgY3ke0D+B7w23JHA9XBb6CBrgAQ9lYjl04kV0Iz+XkuAr+JwbFNJKGhowNqhEjs69R2QCmA2Sjnh8FOmb66dBXyVlNyMuRWYEK6bxJn9LVbbitS9l0S/98IQpdLlU1TKGQqiWZCTsmQJzmySAN/mkJ2iclWoN1A9qTjwkV7kOPMbtP8fXSoYOLBZzMkmvg=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3250:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;20:yHrhD+psEuih/sBEnRKMEW1BRsXS/c1qLr4t9jh4L3lRiXZHHvX8J9rOXWRNX9pNAf7EEqHT6o7gai4CUXGUspduPNfRFvJ+mQadY3Aph//MR4cDpKJJChmH9mFt9SGdGxcdvreokLw7FpkwviKJ+EkTu6QGV2RJD4WGl36Ae28LGDZuM0/ZKYpfsYvQ8S9GaWq2GSLPx1AfgbJStX44fQA4CiJNgA/uMn9CveOh/dDMPRGQuYt498znaOnlUAGwkZ4/raogtDAPI0NRoLjh6/8zv6zyoOEAxkX6f46TksfByccpHLNFt83kvULuzwWckDAmPqDEolwdUEOgBBiZ58s0Xdsxv7O95kLUKeQs+zR8VdaPWBzaBsvKqBdTDA3kJ9wsmhgbKMVdhZmJYFq3OeuVzzCG5hKUxHaNirQasVJtrCchR4pnfWYUpnG8qjfr24CKlgVs/QL7FX8FNM006dJgf4Itjo/eicaseaf87erWgblFAPTGDB/JfqrmhuIm;4:iUPIH4siCHC2/xC0BreiMPzIUwd/fFu6EbjcpYjAKai5nISihE6ZMs7dnXuwJ6pAsXJcmrzKgH2/Q3GK/enG4vwPfDD5GRJUUc+HNH6VU/TBsJHwHdxeWyWiFjiy5Tn82Cv/0wTnhxxfGZbVZ9uMCoWHDdOYWEU3xSjDOMbzkYdBWHLR7J3hx/35Fn0rbVfc03EfidNfPPTtdc7ziA2aDxaU3HixrPv8N2aCg+YdKH87rlwxltOZJxQr45b6UJKhyTbkcuj4IJd5jd8KhcGoYeYBnIqtSfJQmhCwNN8n5zGAki5em+JQm+zlEjSkieO+
X-Microsoft-Antispam-PRVS: <AM0PR08MB3250146FAA830B186CD8F051B0000@AM0PR08MB3250.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AM0PR08MB3250;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3250;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(136003)(346002)(396003)(39850400004)(366004)(189003)(199004)(6246003)(53936002)(11346002)(486006)(476003)(2616005)(54906003)(6116002)(105586002)(77096007)(97736004)(230700001)(4326008)(3846002)(106356001)(186003)(446003)(16526019)(31686004)(76176011)(8936002)(52146003)(81166006)(23676004)(2486003)(52116002)(386003)(6666003)(65956001)(65806001)(66066001)(25786009)(81156014)(956004)(2906002)(478600001)(26005)(50466002)(53546011)(47776003)(58126008)(64126003)(8676002)(31696002)(6486002)(86362001)(229853002)(16576012)(14444005)(68736007)(7406005)(7736002)(305945005)(7416002)(36756003)(110136005)(65826007)(316002)(5660300001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3250;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUwOzIzOnJzSjRaLzBxMDB0RkVzcUpZWXBzYW5YVTNR?=
 =?utf-8?B?UmpKbjM5K0dodUdyMStjMDdKeHBTWFpkeGZVZGVZdmxraEI5YnVjNFZ4aElK?=
 =?utf-8?B?RTJyMDR1VWNHVkI3RDEwRXZKQnFrNG1IQ3VJQUd3Y3RoRjJkMDZsaXYrelRM?=
 =?utf-8?B?TGFIMzFqSldHcExLQ3ErRElyQmJIb3FKM0FEcnBmRjhwMGc5YnVWbGZuYW9a?=
 =?utf-8?B?UlJCMzlMZWJsbERFQlU2ZmtWT1pPWGFXVzQzREhYaDk3QkdoRUVzWGZoWEpT?=
 =?utf-8?B?c3FZVHhDZjNPaFB6ZkFyY2hxa09ScHFFSEd4UUNYa3h5OUtzMk9tUkNLb0s5?=
 =?utf-8?B?WWNxdHVyYzQ3aXBHOW5zeDI1RnN4UEtIQXNyYmcxbjladjZCWDU3RzJXck9N?=
 =?utf-8?B?RHg2cVYwVDhTUngxM3VYdEZ6RVRXZlBLa1Y3Y2I4WHQ2bjhkUXlCTnQ2cy94?=
 =?utf-8?B?WFBBNno0L05zTm96SGY3MXhTRGo4N20xK0hpTTF4YzNBbkl2NFJQRWdFZTlK?=
 =?utf-8?B?bDNzZkhVeHVZTzRmYjIxSDFGNVErcTg2alJZTlU2Q29XVmgvNzJLN2lrbUI4?=
 =?utf-8?B?NXhjQmFIM0FoSFpnZUVLNVdyTVFYdlJmUm1HbS9HZjlLOFBLd3E0azFJSU1S?=
 =?utf-8?B?Snorc2VqdXUrdm9kbUZsUkcwbHNzci9hYXZ4YTZXOGd0OTR1WXEvU1BpZnpJ?=
 =?utf-8?B?TERtcis4anB5b3hYWE13WUpLcUNDSWxOQUZGNHlld0I2V1R3SWh5QTJwU2V5?=
 =?utf-8?B?NjY0SUdIYTVOU2t6b0h0QzUwcFdYQW9LRTRubFQvcGk2a3d6czdlT3FpbjFu?=
 =?utf-8?B?dGkxRTZGQ1R2bmJWUFl2TnZPRTZWZlZ4M3kySjUybHB4ZkpsdTUySnlSbUFR?=
 =?utf-8?B?ajMvRENLYVZZM3NlMy9MR0crR1R5aG1PMThqbDdWNFMxRlFXOHViUFNBbkhF?=
 =?utf-8?B?TVV5QmhST3FqM1UxTk95VXpud2tnL0tkaC9wTVM5bUVhcDFMeENHc3kzaHdH?=
 =?utf-8?B?NkVxV3AwWWZ1Wk96RlEvd0QwSjhhVUMyWUN2Nlh4L0FDTHgvZ050aThBblp2?=
 =?utf-8?B?QUNlc0sxcDQ4N3lpWlNBcXZ6QXIreFFrbzFlcEg1d2d4bExNbFJTclFVdFVD?=
 =?utf-8?B?WkY1ejV0M2hnZnQvYTRpRHJjdWdELzdwanIwb2EyMXBVRkxodjVMSGZlVUJX?=
 =?utf-8?B?Mi9pTWE4Yk1YNUt1QlNyVkRNdjJzOU44YjR0c3JLdjNldk9qNzJDZXlmVHNs?=
 =?utf-8?B?VlY1SWljNU9BZWZodlg3Z3BHRnY5cVREbzFQcWcrZmxTMjVBQkdraDJXWU1C?=
 =?utf-8?B?Mjl2d2xxZUdDWnBFU1N3TmM5dkFwd0RTVFo1YUtiaXMzdldqVFNtRkJqdUdO?=
 =?utf-8?B?dHBaZi9RakNpU3R4TERvRVc2R01jdzQvSGQrNmZsTFZzUENKUFNVZlJFZldG?=
 =?utf-8?B?YTB5MUsyaWpsa2RoR0UvNjhPdFlqRTVwSzJCS29ML1N3OGw4Q0JXQmlCc0Uw?=
 =?utf-8?B?VjJicmU3a1VkUzFLSVExQnN0SGpudlNWeHBLbGV6cVFhMUlMT3lwMVcreVFm?=
 =?utf-8?B?WVpMQ3FLemVXYWZwcWR0aTZrUVdhTTk3RXdBVmMzSy9GOUhzME9Na2VxTHRs?=
 =?utf-8?B?RDRMYmVuOHpZYkhzRnZ6ejU3djJxblBTcWREZzBVaU9sbE5lQXZhVHZHc0tl?=
 =?utf-8?B?TUx3akR0eTdwNDRxSEZlY2VhRTd2MXc2WjAvUmoxVUVYaXpDRnZ0SHpmRVV4?=
 =?utf-8?B?dUpYTHJQMTEwR0pKdVNWcElicHY3ZVJnLzJ5SE9NZ0tXOHZFd245U0JJNnll?=
 =?utf-8?B?aVIzdTR1ZUVjREgrY0tmZWwzZTRCWUhnOUx1SzN0MGM4a1NNQXFvZVp5N1BQ?=
 =?utf-8?B?R1RtZXpQWVZOVitTV2lkbm9YUlNuME9KOWZySE9mVWNBWk1UWEF1TWtURVlQ?=
 =?utf-8?B?RWVxSlpwb0hmYXh6LzIraEZpNDZwK016MkNYZ3dleWJuL2REQ0FTZ2o2bTdS?=
 =?utf-8?B?THdNalBTQUJpQ3hoUmdnWERPemIybStRdEJ3RXZXZGF1ZE1QUkFaYVp3bkVO?=
 =?utf-8?Q?Vx6c=3D?=
X-Microsoft-Antispam-Message-Info: aGh+nWlA131MHTeTLrfwTpMAPz9J1tx+kaRx0VvvPCrVzwSLLb7buAZ6gjz2i0TOAEKcYiptRkkMpmpnF4PBxiL+r7dcVcIilLnw3GkmFcjOO1c4v6y0VxQnPChHsHr+VP68HIoEkEfxAI9vzkng1CrLTO6d47rb39gMIRg+bJDsZVfkIToiwHRhucd9g15HweZlnA1/+dzVD0ldvpjXjfCIf+DJQdJFT4QSp4DDCqI2xDGFIfl+C1kOteTs0kA9XZ+Ps4wqQZagwZqIf6yLelBmJBJYg25nkU1IaH0iLGQoZAL2XMmIQuqCyV/O3RI2fvtQ1FIzoVzpg8d8CoQ7sYYNyx+nWtREe7VSKYmcNuc=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;6:XMvQ01tWtDzmVJZGkzMXFmbeqvp/EY+Xg9MI/PIzcYS1GTkfYQfjTimsz7gA+3sofRNmaMXVeSLUbk8vKP9Lzom+sWNt495bktPNlzLG7Wxwx7jg6kRjwI/mOW8j5RLRSh+MIKOwXipAFNXMrKbZfY9QzLlu0oLizz/XGOy7w1TEIJfv7eE0AqaINdQst92ZRFGMEg6Qo+a50a3EOoA3fzEA22U4JoIFzJeEMN3ebOxz6TfT7iM8/9zuI0+Hr/LHKRed+XMm0iXZCVcBMgctvKqQ0oxpXrk3ZBG28hYGs++MyUPVaCk6JEDsbAgu7fTS7T2/zPCtGvyj31+cQCcoanwKn99BRDPtN7rP5EN9/MXvRYVlaiblL7LeyldOKXFEgchCx39OdDwWCrnISHHraC3wsKlhHg8EjnKM48f5LRj6wMOqken2mtS+guJH3YxSROqkr26x0sG2iy+IPrcsZQ==;5:l6tYDoXESvgnWNyT0bZeWSdRvVgIojS1fGgJuU4S/xh1OMZtOFuOI60zZhswv1KoW0W7I56BSh+VIaBQiPMjPcabsvu3umEIiQL77dwV4/k5AlSg+YeHOmnUdE0KZU69pxZbrvzfmz0/JQrIk58Y42HVXkY4KI7GdP26afXe264=;7:yjYVXAIIRQFUNDXiTjlPjI4SOuemVFdG1jnjtWJE8CWmHuLIyN18vZ9azYNcpLC0DxPGa9tmikaVJL1wmK0zgT9r5eAq1wiHodJFnnzttLGzrdHj+LSlPBlFVAuk8TvYZTSLZOF1M1FARsxvqwjnJfFOIoOPrPRYY08aT6F9+EoDcJmlSaJPGIHnPIRKJZZFTIusO2sH/gy8gYrghqvzC25/HlhTPULOr8coEknge0YWDpE0n3buNZQRtaTpolAG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;20:kL/FcqxfSCqw5FKY1t/xIYR98y01b27SEQqF5NPP3lFss2g72GYSEp1sO5NCKgqIPHewO7qySICwyBSfsV1D1GWMszcPZgwMupXm5fyG3alWVuXJUtqV0Vxa8EK/WzBH73LZTLOOecf2css6ZQlzUlfsunSFh7kYvXG+XOINWxg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 16:10:03.0615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0064547-3e65-4018-03cd-08d614dc606b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2018 02:35 PM, Andrey Konovalov wrote:

> Andrey Konovalov (18):
>   khwasan, mm: change kasan hooks signatures
>   khwasan: move common kasan and khwasan code to common.c
>   khwasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_HW
>   khwasan, arm64: adjust shadow size for CONFIG_KASAN_HW
>   khwasan: initialize shadow to 0xff
>   khwasan, arm64: untag virt address in __kimg_to_phys and
>     _virt_addr_is_linear
>   khwasan: add tag related helper functions
>   khwasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
>   khwasan, arm64: fix up fault handling logic
>   khwasan, arm64: enable top byte ignore for the kernel
>   khwasan, mm: perform untagged pointers comparison in krealloc
>   khwasan: split out kasan_report.c from report.c
>   khwasan: add bug reporting routines
>   khwasan: add hooks implementation
>   khwasan, arm64: add brk handler for inline instrumentation
>   khwasan, mm, arm64: tag non slab memory allocated via pagealloc
>   khwasan: update kasan documentation
>   kasan: add SPDX-License-Identifier mark to source files
> 

Aside from nit in 16/18 patch looks fine for me.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

