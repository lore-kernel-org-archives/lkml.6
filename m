Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E0AECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC97021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DrMG4xu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC97021547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbeIUUeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:34:11 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com ([40.107.7.117]:2432
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeIUUeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek3HUrozDXXZYlJqs3whXBC/FNGxhYLHcDoTP/k/wD4=;
 b=DrMG4xu1e/1OXW6ujm35mGasKfNpI+QwfMRbG1/FWhMY7K6XXG/UfLPTDMlIVJqGOr/cTp7HWroGw73eIYOduGl4RckA/vSf8nLmUEZQSNYZda0dvep0ugZWwl9Gfh0aI0JcYGqIttWJTB1qiP1mu2JjiFbXO61FH7OGpakteB0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3256.eurprd08.prod.outlook.com (2603:10a6:209:47::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 14:44:53 +0000
Subject: Re: [PATCH] kernel/kcov: Replace vm_insert_page with vmf_insert_page
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>, tchibo@google.com,
        linux-kernel@vger.kernel.org
References: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
 <6fa7d32b-07f0-ab6d-8053-021b171153e6@virtuozzo.com>
 <CAFqt6zbp8wynKqFRyp3Q55Scoi9ojfdCVkMrxC4w9qxPxWMXGQ@mail.gmail.com>
 <68b8cbf3-1b5a-2311-ac09-a8676280e85e@virtuozzo.com>
 <CAFqt6za6VJ7vmWEqg4JGWqRiqbfc6GYDnpUeBQ+03xdY51-GQA@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <0c3d2ba2-29dc-ed02-0919-54d1d76a1eb1@virtuozzo.com>
Date:   Fri, 21 Sep 2018 17:45:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6za6VJ7vmWEqg4JGWqRiqbfc6GYDnpUeBQ+03xdY51-GQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0064.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::32) To AM6PR08MB3256.eurprd08.prod.outlook.com
 (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54c4cc74-e6c2-4d84-3741-08d61fd0cb25
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;3:gzE4aLKvtEDV8GvXaVrzTYtW6hqU+T4rwgcy3FwsFNG45poCP30mynJRmxxUKTpK2NUdFiTYAv5USx2CtMHavyCdaEXp1Y5/SRYQbYO8+JkZTdxi0IA9as2FE+Hgr1kjableJGsVb68HdIWbVoOSv/JQo6xeSVtfQfxNxzSArpc1AELDdkSAtJsTyH+Ax9ocOqtI5gZqxTcFE7SJOXAn6rNJIjpJytIt1/MWrKY1GND/DCGWNjOh6ZSnBrBnL8w1;25:FnCdWXGLdlMStbtthdLNp/2kyXOfjAkp8O1l2bGHWAg972hFOeYabEXNDB52Cbk5MFV2yV5a/jBioE8WKmTi0tDq2DN449GiNPPXKQVQFlQWnWeFVjvreJP5C9wlMfA3hz8BemoaCQI167xtLtItH+MJAmT73xTdA6BUaLnZn0SjuRDDPq7ELQ17cfseu7NsHoL5iadJL9uM6Ai/eTgUDXrVwLj4/v/E8u8H2iCncSRVUEf5r1OE37Bs8gaosM+X+Cg+tKJ0eUITRS4tamR01LRG7p0eCrYIpMucDxCNZMUUMznqt++jGppqkTvAcim8cpR/ssYKf03dNlM1ahdihA==;31:LDQq4+K/MFbfgIIBZx6/il1FEkMjMRbJnsBb0CnB6h6pdfV+/FjgAaTfUisX7AMDSqKpPYKc2ByMDb43JbpcGgSQR1j9iqnTbEN7RvFpKkeWEScAJwS82Dc6EnLwqqKtRLRNXW3U3Z+8YfnRfv2Q/tJRlWlMxWujbuSkGfRBp0nGqmBeGWEnOF8AI68iHdhG8wPsSWU+hzf5RB4fRZNS/VtdzNK5LdRQuO+H9l+RRMw=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:KujWf0/YyeKZVjAiW+LMzXYY6N/UdlwbgB3x961TYYwe0XoCpMovQuJUzT30ln+HLpZdhKSLD/4KJOP1XqIy9ESH2k6bco0Lu8CGkQLTSS3xsjVRe9R26MnVJrZb3QFcPv/mu4+VOqjbnhbu8D/gMAjnSaXl3KCWh0xJOEt0EGIw0k+EOyOL5rsGQOpK7loQg4kKRPrQgaazepxnOtIZZBFhkdUiuZwC6ZCeoLBQYUYZJ9E74y1zDFlSRgRRFf2twkB7tZDwMLHw3oFNbZY4ZVK8fksi0v9UgLOOwX+IIgPwv/CcAA8sj/S7AZOi6fKCLM0fR5NHNneMyGZng02/9tBchAyFU5zMRYXdPf+iHOn/lXQbek3bNpshjgC/hBKVZNn5KxakPvn+2jIKZ2Yf2HWy8o/84DzfircdoyJh8hynBAqoakqpiGGr292XlfMsFDPn7We2yDhJyLjxXt/pfO5TLLe+MBU5a5WiJtjhOi1mu+3aFuqGgrn17FsYfjTA;4:7FDxQNsw5xShFiTQGfEenuovjdMQKl8Skx59rJ5NRbNGA/zSIDJbm8kycnKlTa5pHw4QGq5xYrtABDdDqmKImTeFYNL+mhEvS8Gtoo6ZNZ0V4E7YmrN84vnZU7gnouo0EqktQulHtbgKUmvXO6O9nPPDkMB+cRjNL9xItApQXPx6wztmp2wI1btGT8RKbDa0FB5Xw/yTXxYvSdP8o3JQ91seuUrIgr+AejeTdnq66zth9Z9o+rsLeOz11THh0ys2bu0kkt5tjOrksaO/srMdojNY4C9bB73QD1iE0yl0k+O6QWrQ5kYlx1q/D7Sq7DcG
X-Microsoft-Antispam-PRVS: <AM6PR08MB32565F91E01E6EA03E07CECBB0120@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM6PR08MB3256;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(136003)(396003)(376002)(39850400004)(199004)(189003)(93886005)(47776003)(6246003)(66066001)(65806001)(230700001)(2906002)(86362001)(14444005)(53936002)(105586002)(3846002)(53546011)(6116002)(52116002)(486006)(386003)(64126003)(476003)(81156014)(81166006)(31696002)(446003)(2616005)(316002)(956004)(2486003)(7736002)(305945005)(6666003)(6916009)(11346002)(25786009)(50466002)(31686004)(8676002)(76176011)(54906003)(8936002)(68736007)(23676004)(36756003)(4326008)(77096007)(65826007)(16526019)(58126008)(186003)(229853002)(65956001)(97736004)(106356001)(39060400002)(26005)(16576012)(478600001)(5660300001)(52146003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3256;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU2OzIzOmlpYXUzYWtKbTRKU2NiVXliWUl3WDdhK0Zi?=
 =?utf-8?B?bUdzWU5xNGNORmFDUmZlWStPYXdJR00rbVVqaHRDaG9wT3JSdTg4OXU2TGMr?=
 =?utf-8?B?UmxVUTNSeU93aFA0VHpkYm9WUzlobWVtMXFnVStweHh6eXpuMVFwYklBQlUx?=
 =?utf-8?B?bTdQdE9HeXcvOGY0N3B6OFdhZGI4bzlhNmR5b0c0RUZpU1AwVGVXam9GUCtJ?=
 =?utf-8?B?allWek5LV3BMRkk2QlRaNm8vK0dsVXBXYkQzQ1pSZ1RzOGJocGppS1AzWkk1?=
 =?utf-8?B?ZjRFVExvUlZ2a3BWL3JOMlhOamUwcDB1VkRrYmlOZFJZN3ZHQ3MvL2dqL1Fr?=
 =?utf-8?B?QjRDK2VCc1F1VkRDTEVKUkxMVzRWTE81VnFtT3cxck5IYzRuSWVoTXpCVS80?=
 =?utf-8?B?cU9ucDZHQ1VTOURCZ2swekY2Yk1oM2hJdXZJYmo5SGNKSXg1Y2pRT0QxRG5B?=
 =?utf-8?B?Tnd2Y0dzSWoyN2ZISGhxM0lmd3VNSVZpNCtYaXp0cmo0ZXFid0wwR0FTZlBw?=
 =?utf-8?B?RmhoZjkwUGExbjRCK3RvcnFETVk1dnc3ZDgybFNzNi9rUitzNGlGQlBHVmZ4?=
 =?utf-8?B?MXlCUmdKVWkyaU9PS3EzN1dGUlFqVXRkRmhENjQxa1pKd1lUZjd4Z2NySjVK?=
 =?utf-8?B?Nm9ZaDhZM0dKUnJhd01qOXZad3ZHQzRLajQyNC96ZTVjdUowaTZJblQ3aWlu?=
 =?utf-8?B?Y2lRTWs1L3pCV0s1MVZYMGFKOWJsVHNEdEJwZmh1WDhLNjhrak50Ykk3TlJO?=
 =?utf-8?B?T3pSaFg4RzR1clI5WTdpK1lqeWttMUJsMDU1cmM0OXVoQ0JHOEVwQWR6S2g4?=
 =?utf-8?B?aXpEZGVWQjdJQzZPeTUyRG5iVGxCa3BLTDR2MzlTYVkvZFNmWTl5eUpCVits?=
 =?utf-8?B?cEdqem9md1lGZ1R6NjZ4aG1LT2RiT25Ra0RRY2lNTitRK25NZHVVL2duc2dJ?=
 =?utf-8?B?MU1kM2VlZkJEcmN5QzR1cWh6RnJiRElPdms5RVI0K0xkZUN0bDBEY2RRNUNm?=
 =?utf-8?B?TXJ6TFJ6TC9qSHRkUXh0L2E3NGRYK1hBTVdNOEVRM2R3dVpuTFArQlVyZjdR?=
 =?utf-8?B?Z1ZQZXRTQVdNWnI2YmI3YmhQdTM2V3VzZytUTkRobFVmZEU1QXFZWDJvbnBz?=
 =?utf-8?B?L0dSWHNNektNeUVqcGRjaGQ1SVVoRDBXa2tmczJFQ25JUFRZOE1pL25Gc0VJ?=
 =?utf-8?B?VllYR01TZGJYbXN5UjFTcEZKclJadDdjZktWS2hFQm5KdFZmdTFrU0RoczhV?=
 =?utf-8?B?bmJ1WkNjdFBqR3JyTG9rN29tT29rQVlBTGdvYlkwc21qOUJBSjg3dndTWWNM?=
 =?utf-8?B?NDU4NitxSS84YVlFOHVocGRHQjNZdW4rOVFQRVVyM3p4c2lGSDdpSWZ3NUxn?=
 =?utf-8?B?ZHNDWG9EZmlqWTY3ZklRWkFIQVp5VjJnNGJkV2plQUZGM0E5UVQ5aURCQnJt?=
 =?utf-8?B?YzFKUW1SQUh1OEVkRk83eDlBSlhOVi9kOXd4OHJiVlJwZ1IwWnpOZU0wczNY?=
 =?utf-8?B?Y01nbUVERVRuY29BZUhMWXUyWnhJQm9hckZoWTRzaEVQYmJ2WHB6ay9mZzBF?=
 =?utf-8?B?V2hwQXdFaFJLMmVYSEN2c0w4eFFEZlpRcmZCa2dHM2QzeEg3aVNRb3daVzRz?=
 =?utf-8?B?azV4b05uaDVtTFBwV1h3T2hzQWZMVllMS0lSNjJia09YbitTaTI0RGxCSFNP?=
 =?utf-8?B?NUhsTHJIalRxTjdaK1hFVXBSWGUxdmllOU5sUENHMVB1NjlDZXY3a2o3SkZ0?=
 =?utf-8?B?NnYweE05MGJnbnNXdit6TVJhOUZBQjljY1dHVkFVUVlQTVNRMUZzRzJZaTBN?=
 =?utf-8?B?NVI2T3NFay9xTm9vR0xudjdNK1V2NjM5dit4TE1zLzZqQUNQNVJ0ckw4amlF?=
 =?utf-8?B?M2xQWE8zS21iNnVqU1RaRGRBRkdMNXQ5WVpHOWI4K0JWVzdVZkdEOXRydCsz?=
 =?utf-8?B?elB3N0tGTVZQOFJxQ3JkKzdHODRSQWNwWGlBMVBvSGdETWJocHd1TGEwZWdu?=
 =?utf-8?B?RjVoM0FESU5VSmZzWEQ0SmtlZko2Z1NKUjFZUT09?=
X-Microsoft-Antispam-Message-Info: RBDNJ4anyU1RsWz3FalmCSkKmxJgIVCjS99kk/67xMpJMTrafdVM9ywFI62KRo8Ir+ol7fw70WYJO8eiSGoYmqUMnf0bbKjY+Jj4kTZsIPQBf8SeScOyA8QAqa8yPU38mSNJRuvr13KRWyPtsAgjbUz6Mwqg+7enY0DpPlQr4JuAnIGJ1v7yY4Kp8y91P5GbNYih2TE8n3nWQM7/mePTPfifYMnyAoRzGZkGE9WTI6sbpaUEEWNNlXLAshmqzjWtByqwGe6Rh4MBWqwqWYu3hLFv18942FgXTZF6qluu2DWZ0uwn5Ri6TUscEtOQc8n1ZSCL2XZzWZZpxL27xoticgA6Nz1WXKZPIwoCBv4ek3g=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;6:eDetUBg8CPr3N7sDHBwhDWIXcgecvYBDMro+5AYICOVmM42nNpSsfsAf7N3wIZE7luruXzb1nSdfYS7r9pRFmzB71iVTauQy7obe6ZeSSD8mRtQEErRcoj8GZFbIcY5v61fB6MtF03ceBD8iK+zXJjHzbz23oAkKm35fiGklhI0qatb5IWLUBdsSbn9l5+k/yY9WdGnAfqIWEaPahmh5Gf1V8H/PfdsI6nwgPpM7p/QxoCmOHe7hHz+cEsY1vtRMie/Noa5L763hSF6PLVnYCvf/WTutjIdWhtj9ktJlc3A6TWItdNddUEX9/mf4kJE9ReLfjr+3auS6DrWsjWYiUcMaWmkt1EyN70ULedCtmBzUmMooilQWkOYTKIY94fow0jz7AUjJzhsZUxCdrYZxIKRIYSXsTKOGa4lu8vWUvT8I9DCdKLypnxwSG1n+xA9BAL8HLwlYTBGOjPrxm6mJ1g==;5:9kqvcyZHhWpei1KN3Vi2jSUc27yLiFi7yy4XNALwRSryFWcjkTY9nr4aRYVT89UFB1pL1h6RVYj9mHA8wjuF+kYXy7zoqWQaJ9QiSBc+NGfV9lEW/JuxAaYHw8tBQy6SiLxqK8TBEO6FuqqlbxgUeaJV9PZdePHaMP67MbUwp44=;7:b4CULJgwpQU6s1MU+e2Z0WI6wjKeWqOrTsfocJzVAOon6n0P+5fcdWmRsoDP2IsgRhi2omgwmbHr0WThOoys/H2xL6upH0L2CIFj4dpPwUM3MkDykn0fitfISlhxGl2n7abx1Xf30kCjr2zhB6ZU9f05UsV/V4AwaUv9sJKFMyKUBRLznKFml6fbI3zDNPEL3cTqT4PVa/W8yxsKtjc9gN+3FLbeg01hJAOVW6XVZhU2QsVrbdWOGY6ZTzhtnPJN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:qhBZ+MA08ZYKkktyXhj/0LJ+mGmaJucMesyymzxaLLtVvEcLbg0wKviKVKCwKXWWRDP24s6z5aQKPKvm9TMtjUCPw8i3XKWBSTqADd6VWkEFj1pOSbL6TZswW8chNASD+Isa7sdKCj403BsCBTiOoLFT54VjLEsneuvebjmoWR8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 14:44:53.2470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c4cc74-e6c2-4d84-3741-08d61fd0cb25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/21/2018 04:25 PM, Souptick Joarder wrote:
> On Fri, Sep 21, 2018 at 5:22 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>> On 09/21/2018 01:03 PM, Souptick Joarder wrote:
>>> On Fri, Sep 21, 2018 at 3:06 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>>
>>>> On 09/20/2018 10:12 PM, Souptick Joarder wrote:
>>>>> @@ -293,8 +293,9 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>>>>>               spin_unlock(&kcov->lock);
>>>>>               for (off = 0; off < size; off += PAGE_SIZE) {
>>>>>                       page = vmalloc_to_page(kcov->area + off);
>>>>> -                     if (vm_insert_page(vma, vma->vm_start + off, page))
>>>>> -                             WARN_ONCE(1, "vm_insert_page() failed");
>>>>> +                     if (vmf_insert_page(vma, vma->vm_start + off, page)
>>>>> +                                     != VM_FAULT_NOPAGE)
>>>>> +                             WARN_ONCE(1, "vmf_insert_page() failed");
>>>>
>>>> Nack, don't see the reason for such change, it only makes code worse.
>>>
>>> Yes, it needed.
>>
>> No, it's not needed. vm_insert_page() works perfectly fine here.
>>
>>> Going forward vm_insert_page will be converted to
>>> vmf_insert_page. As part of it, this code has to be converted to use
>>> vmf_insert_page().
>>
>> This doesn't explain why such conversion would make sense for kcov_mmap().
> 
> vm_insert_page used to return errno which individual drivers have to
> map to VM_FAULT_CODE.
> There were also places where return value of vm_insert_page was
> ignored and return a
> TRUE value.
> 
> As part of vm_fault_t migration patches, we have identified and clean
> up all these.
> The plan was to introduce inline wrapper vmf_insert_page(), convert all
> the page fault handlers to use it and then convert vm_insert_page to
> vmf_insert_page. By now we have converted all the page fault handlers
> to use this API.
> 
> Still their are few places where vm_insert_page is called outside fault handlers
> context to map kernel page to user vma and kernel/kcov.c is one of them.
> 
> Now removing vm_insert_page from those few places one by one.
> 
> Going forward vm_insert_page will be removed from kernel permanently,
> so that new drivers can't use this API and create new errno to VM_FAULT_CODE
> mapping code.
> 

So, to avoid addition of new code that converts errno->VM_FAULT_* you propose to add
new code that does the opposite - converts VM_FAULT_* to errno? How is that better?

And what function is going to be next? pte_none()? It is also used in fault handlers.
Are there going to be vmf_pte_none() and complete removal of pte_none() "so that new drivers
can't use pte_none() and create new pte_none() to VM_FAULT_CODE mapping code"?

Don't you see that how that doesn't make any sense?
Want vmf_insert_page() for easier error handling in fault handlers? - fine, use it in fault handlers.
But leave the vm_insert_page() for the code that has nothing to do with fault handling.
