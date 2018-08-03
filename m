Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03C0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BED2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B0V4dsnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BED2173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeHCM4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:56:13 -0400
Received: from mail-eopbgr30091.outbound.protection.outlook.com ([40.107.3.91]:58181
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbeHCM4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy1h2BuYgt/PTAPf/bxCct+cVIcfCtKYsUVbORKAA34=;
 b=B0V4dsnADSjm6Ukn9tPKJYwu1UM52FQs5Vs1zaG8fktBufwM0mrCRG5e5PnoyhlUtScMTtJ8IVTueucYXqUDHZ13JVQGeKMllxvE13Q1fkqdwP0oSJx5NJOVppldGGGz96Tyw3pMpdyjAXZiYIZRC+CblArNuzsOISOe10qvDYM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2017.eurprd08.prod.outlook.com (2603:10a6:203:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 10:59:37 +0000
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to
 do_shrink_slab()
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, willy@infradead.org,
        shakeelb@google.com, jbacik@fb.com, linux-mm@kvack.org
References: <47c34fad-5d11-53b0-4386-61be890163c5@virtuozzo.com>
 <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
 <20180802134723.ecdd540c7c9338f98ee1a2c6@linux-foundation.org>
 <8347.1533292272@warthog.procyon.org.uk>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5250d5c0-0d26-260e-dc39-227b8e355a1b@virtuozzo.com>
Date:   Fri, 3 Aug 2018 13:59:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8347.1533292272@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:203:51::22) To AM5PR0801MB2017.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9184467-87b8-4676-10a3-08d5f93034e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2017;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;3:pbmks2pehYeZtvPg4URmCUi3PZRVysUrQvU9g1EgdxUOHwE4qpkJ+9Oz0RjIz2YLq3zE0lNF93LTurrozbffpzXcY/lJD1IBsrNkx5hXtJkNEYsdTmy5LLttoJ4lEC8bayb2aYLyiKSdoB2fu8YtkzwWXBWN0vUdTXnEuvL3KKkXrJongKtn8nWejSO/PdEUmKkNiqGcnrBf1bgH+rQvrA1HBzJ0+3ZWpduDUcR4XpHeLOhTlxxzh3zXftmvKmm5;25:crQeERiomv0A+lFqcuN2Tejgt0m9Hsm4L4uZyMHy4oQfK5brBLU1RYZ1HlMNTzdx6MCTYKYD9zxFFLwGCHK/2DVlQ2LH29qPRhTqCvql8H+23XWLBeTSs/qf9W1fxApbmsl1sgyTvn0kshAx/6kQoDiBkdn0PsySUA9PWSBBf2gz/6n6xzgIiSXXXWdPhKmlNifd0+4nH9JJ9/O1gVmPrcVF6bBap92RDD0CzAxRn9pQWqDgRyrZyOl/8pyYAps3RAKpzZD1NBbAYAMGl5m06gaA01xBH81FsRg1bFxVoemKd9IcXS4QIh7b4lKW0ecV5qyGLMtgCiava6/QujZVJQ==;31:czsQFNdV1hJeVOqzyLOraF00vBAH6c9oru6FgEpU4EbB9s8D/TNgLKVfDa290cuRWtTZak4Jul2THssgH7YzVn3b1m4K5XWKxf2FmL6iFm3m0lNrgwortL6HJ397fjmUW1aHvWlGBoAUHEoaIgMyzFHkKE/004Gnsy7TFHXaHRZzJZ/Armr2RD5RFvXsUJzC3wDGX8MFCFktepyp16ApoBir/QPJj8FvbYToIxecspI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2017:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;20:xmvelihPc4ULYdn0Vh1FZINTNIOulYqMlF+DmbABVb22jMETAMJad7ubaIoLKMelup+SqOKQEWnyvHfXZKPFB6+FIPZ0Vq+9f4KQmovxPRWfXSrXRlHi2ax8KsarsTQ9lAu4tIKoAiaYubO6TDHvXyJNxaILrXqUTTrCl82WR+r2qqnUfKaiVktc/0/D1X62shYRCMg+wF00e3fWUyhKHFnn65RcwrseASnS/NEmQMqITlBm4B4c6O5IIkNHY+9zrLey6hHJHN8FEvVJK9XsbSG0ioN5ffcM80xQ+rk97H1le/DKskRDc0GV8S0xRMnWun51PJt5icg/mGCPbd1RCEHcE6reg0hMqz06434MdCcTcGmlF3ndkCKewDRodIdE+1tDv4jr7Ud5hU8XCYal0c8qCIfzhUJ+arSsOQ8SIOjRcBKdCrk4nRbAdWlilUpTJ5o6gG6Gj+Fq7dDIIIwDUuVjw9z+/5wZT/R9wd89EtG/uSyJJmdPcbtLxU91fJke;4:qjSjyZAHV5NBHOgGlReWINS6IG+yo3YiXCpTAlYpDsu/K4Qb0vLhXO6gWfacQNMfaYXfR7yG/h4/RdYx3fqeYjTj2+aNs4Jres45zZgaM1endfX084SEPyndm9QLkPlLY7hgCQox9MrtoiX3nUNH2O71cFRJmkbh3MORgon5km6FT7lUyWZkJrH69gqlzMSir9PUCyOjF0a6rhDwQoPU65zSPQoMKz2xf/b6eWUje1BTZt7Qg8PaXibfU9/uRRCcTt2zJwjJQvvgYUf2JDKC60t+/nnEIQ62+hC1T2tXSOEivMw166xq8lpjDb37/NZtdXh3J0n7qmNHPPFW+WbkU56U84WvU2iffPQXsSa+SjQ=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB201729A1F4FE4CB0B09F613DCD230@AM5PR0801MB2017.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2017;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2017;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(186003)(305945005)(230700001)(68736007)(2906002)(6116002)(5660300001)(65826007)(93886005)(3846002)(26005)(106356001)(97736004)(77096007)(8936002)(7416002)(36756003)(7736002)(8676002)(16526019)(81166006)(81156014)(64126003)(53546011)(6916009)(386003)(316002)(6666003)(31686004)(446003)(6486002)(65956001)(956004)(4326008)(39060400002)(76176011)(53936002)(31696002)(25786009)(66066001)(86362001)(486006)(47776003)(23676004)(52146003)(52116002)(11346002)(2486003)(2616005)(478600001)(229853002)(50466002)(5024004)(6246003)(65806001)(105586002)(16576012)(14444005)(58126008)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2017;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTc7MjM6RDlINVRtWUMyUnhoem1Fb1pvTzF1cEZK?=
 =?utf-8?B?RWJCSnNNaVlGUlZsRDRiOU0zbmc0MDNZM0VrYnVMWmpqLzhod2dlOE5NemU0?=
 =?utf-8?B?Z1hOUWYrU3E4aHhaUmhiSjMrK05RZmlmVS9BNS95a3NUUVUzQVJ5bkg0L1BO?=
 =?utf-8?B?ZWRRUm5BTThLdVhGMTRkVDVWYmtaYnFrazM5ckp6dGxoamdXNDhYOEU0eEdR?=
 =?utf-8?B?UHNaVnFDeWxxMEdJVUlJcEpBQ1Q3KzdlT2JkOU1zNmFnanNmQjNFOXdZNy9k?=
 =?utf-8?B?cGdUZ1RLUTBobGZ3ZC9sLzhyMEt6WDVpYThwZ21MT1Z5cTh1YWtQRzdLTXV0?=
 =?utf-8?B?K2xJNjFwdGc3MElqZHhKaEpJUjF4VTlPK3ppRGFOTVY3NWw0QmtVb3VLL1JY?=
 =?utf-8?B?dktUT0wvZDM3YzhxQmdBU3M1c1p3N3NqQnRDdUN3VUhaYXBYbS9jNkJtMFdl?=
 =?utf-8?B?MjVad1NoaXVYZEQvUE5JeU9XSHVUZjhuWGVjcmFWOG1UMW4yZ3hvWUJQT3c4?=
 =?utf-8?B?Ym4rRDNjMCsvMC94UVlMZTdKUEc5MDN4bzgxUVl0U3BrUUhmRTNMa2lXZlNq?=
 =?utf-8?B?bzRJS2srK0EzUTB6SVN1OWp0aXc1aUFzNnd2cU9FQStNd3poVDQwVUs5STN1?=
 =?utf-8?B?WGh6SGNDbVhGQTUzOGc0dVU0NHFWQlhVS3liazd4WXVyTkozRS9HSzUzdHVp?=
 =?utf-8?B?b1BScWR5TTNmeVN1L1doV1Q0UGhaYjFuVGxJbEpqekIvUEh5WjRxTDFCK1dJ?=
 =?utf-8?B?ZVhZQXN4eDhhUjNWY2RFMkJWQnlCSmpFSkNwYUltVGVEOWxRSnB1VElTSklC?=
 =?utf-8?B?dUFzaDhuV1pQTlF3RzlJMGJTTDR5MnkzMkRUZ2hoVFREOVdMUC9SODMxNlIr?=
 =?utf-8?B?Um1oWW9wem9Rd1Z0MWlzREUxNEpQc3I5L2RkWFVJUkFJRUI1Zjh1SnB0MHNj?=
 =?utf-8?B?cWxLWnNMUVYyQWUzaTZlUFRtdHZoVW9iYTEydm1MTUNUbUFuejFwbWRacjlV?=
 =?utf-8?B?RzRSVVA5Rlovb3RFMnFrZ3dYRVNFTFRJUis5dXRSb3NXT1gyTmNyaDhVM2Y4?=
 =?utf-8?B?NWlIVGFEK1AvTDZhWjlpRXJ6Y1J5N2IvQWdLSENmVVVMRHhSaGF5QTMybnhW?=
 =?utf-8?B?Z0k2a0dtMW8xQTFOOThmaUl5dlp5SkJRdlJVK0ZiMU9vcGZySFAvWDM3cVQr?=
 =?utf-8?B?bUNhUG9jSXpyOTNDRWJvTlU4Z2hqR09UQWlSYVpMNWVlTWlUWXc5UnNXanpy?=
 =?utf-8?B?eUxGYjAxa25tN204Wm9xQnpmU3k4eTJlQmYvdm8wZURIWSsrMXhiaGpZLzZM?=
 =?utf-8?B?eGV2YUJhcXg2b0tQTmp3QjhjMXJGdUorZnFuck1JUFdyaGI5bStIeHZSdXEv?=
 =?utf-8?B?YjVmYVAwdmRTaGszL0pTcGxwT3FPZDdkeE5tM2dqa0FBcnNvUVY3SDU5eEdl?=
 =?utf-8?B?QnFnTVUycWVZY0FkMXd5Y1Z1dyt6TjRGNGp6NHpwcGd4L2swQTFTUG1TclpK?=
 =?utf-8?B?bEd1ZG56RDl3WXVIbS9pUkZEVzVqZEFYUVlsdXc2eXdncDRBaGI0UUJJNjF4?=
 =?utf-8?B?Y3NITXQ1YWtVVkNpQ0psUFdHUWUyNnNpSlhUNW5VSXpLcDJuRHBvZ2Jwdnhz?=
 =?utf-8?B?eGVyZExrY2s3UkhiYjJZTklSejBOWXUzUWd2OGRCZVJGMksyZzFZK0FwazVS?=
 =?utf-8?B?WVJuQkVpaVBJNUpQMGE4VHV0b1ZxckIrRFJjNFo0N0xmQ29IYnd4M2paTTc2?=
 =?utf-8?B?Z1Jhc0ZUOW14d05nYzJFV1VyeUdRN1RCTEd6eU1RWndXbG9yQk1LdGMwNzF2?=
 =?utf-8?B?SWxxcU5WK1RnellqbkUxTlhRZytFNVZaVkkxN29OUklGTXhNZDI0MVhONXJP?=
 =?utf-8?B?UkJGcFVLZnlKaktWc1pyWDhPOUdOZ0R3eForWWtnSXRRYzUxVVZvTENaYnJV?=
 =?utf-8?B?Y1BJN3VNdGdER0R1c2xnU2MvckNUQytoWEgyR2xibE5MczVmVUR6SVl6SUJB?=
 =?utf-8?B?T3BTTkowRXd4VG1JcjVKMzVObVZYTStJaVpQd0ZxdlFpS21RQ2o4aHpHaWR4?=
 =?utf-8?Q?nN0waM=3D?=
X-Microsoft-Antispam-Message-Info: B9c7/7EvFVA3qBRjmH9XY0b8ucX+Yd7Qnl6wUo0f68m/Pu5xzIsxY4DYyB62evv8Qze8wB5tfIiP5JnFHfFYQ4QILzMf+s5HT/u6Jho17gGUxgUD2SfqRBf/dMwbQ+a4j/TH/nLCSfKTVaId/LvrtBt8ftjtJV6YtobDQrDEf9LSsixsm3bJ8DNkyf4tb0+3RjZzd3pZqEAOWPCrCIXf4agtImTHjIoCnSGDN/rovx+IpayRI/4r2wrbRHm8ivc/W6x2T5ABwGai99g+HUzAnXmCt5r7HhQ0KltuIHrYVrWqu2+GmdBq8cRMuUApqHoAo+8f9jdgcIior4mhT14TuvwYaCqipVbgpA+ohBRDIYQ=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;6:jqFOUmzUVxPoDpszsHiKEmu1C5oxbf0vjXpXKTRWaEXNHpej+MvGbeq6ZEcuQSobxYKsbw54l7Iu+r5yS88Juxug2HcSbsUYwA6KDziDI7r3/ckOeNKi2GMhntAul/pWg9uoJ+Vso2oTc5qMZQFpndi68GXbd3okV9O+L7il64FSiTOac+f/eCkE4Yy9Lba6YD4y2QwGutdKuaWJyTVqg1+56hAevjJ7Vmu8vZf9u3LYUYZn9B77sdTVKufTWAkrNNvhTfXHNJEY6wMSKBW5Bik9vXojyrr2ITcyPMNQGz3VbWA9f3DfGia3Al8nBpssEMcVSU9/IQNwwlc0bFcD9dWGCeu6zRAjlVNwbGN7Av8NnZhcMo3zTktNV8VsDeVseK44MdGEmCgmKV0qwmi+B0/BTTEQNoyBGgPoqFXb/kNZ3ndsJCvm/dLpIRzrlxF8mmJmCihDfAzYpo+G5hDKPA==;5:nVVmSvBbZZ8hgB6o7/jYO/Guzjx4Cqb665iWjs6frzUIIUUu/7ctdcAIc7Eq24dIMzV4tDDp5qykl0LBZL4MXvtwPBXhgvug4uPf/MMC6HbN+d/1Cif2KATlwIxKIx8lZ/iM1SKqAIoLrgnQ4wGNzPWl6PFXZk30/4r6DiQFbAI=;7:SXYG5OglgLWKBoQrLIa/waq4qLZ+DXSUS3+QT01Sr45/MLQO7AB1klCpihf52nevkhLY1xF1eA1Dflfdb1gVTBXjEMjKJ/kQ2mHhE/44CYZV7E10+vxwBE18z5o7ov3a3YvTzfuij3LPEGQnN4h5T6OZFys4UIeHBFz0VmNgDapu5dzF7Q3z5/1/EQysF/ZbIZ+kHz8qJP4EPtM5EWKR2L7cPox6Od0iwmA+6tZ6k/XgwQ3y3mcSUapwk9zgFC33
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;20:bvIEXvyBxRPl2ZSXft798iQ2jpTzkB97LjbtN1TuxrZK0BpmPL2qp2XZ8rKW8BROxGQg4c+McJ/9Uc6pMYxaILz9QWjGeAlN5qu2PfDMw0TjVSjmRJePpqrpT2B3QU6QtDHwUqgR/utvqWjOTDHh3veTkGlK0tamz0gdDjsR7Pk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 10:59:37.3541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9184467-87b8-4676-10a3-08d5f93034e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2018 13:31, David Howells wrote:
> The reproducer can be reduced to:
> 
> 	#define _GNU_SOURCE
> 	#include <endian.h>
> 	#include <stdint.h>
> 	#include <string.h>
> 	#include <stdio.h>
> 	#include <sys/syscall.h>
> 	#include <sys/stat.h>
> 	#include <sys/mount.h>
> 	#include <unistd.h>
> 	#include <fcntl.h>
> 
> 	const char path[] = "./file0";
> 
> 	int main()
> 	{
> 		mkdir(path, 0);
> 		mount(path, path, "cgroup2", 0, 0);
> 		chroot(path);
> 		umount2(path, 0);
> 		return 0;
> 	}
> 
> and I've found two bugs (see attached patch).  The issue is that
> do_remount_sb() is called with fc == NULL from umount(), but both
> cgroup_reconfigure() and do_remount_sb() dereference fc unconditionally.
>
> But!  I'm not sure why the reproducer works at all because the umount2() call
> is *after* the chroot, so should fail on ENOENT before it even gets that far.
> In fact, umount2() can be called multiple times, apparently successfully, and
> doesn't actually unmount anything.

Before I also try to check why it works; just reporting you that the patch
works the problem in my environment. Thanks, David.

> ---
> diff --git a/fs/super.c b/fs/super.c
> index 3fe5d12b7697..321fbc244570 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -978,7 +978,10 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
>  	    sb->s_op->remount_fs) {
>  		if (sb->s_op->reconfigure) {
>  			retval = sb->s_op->reconfigure(sb, fc);
> -			sb_flags = fc->sb_flags;
> +			if (fc)
> +				sb_flags = fc->sb_flags;
> +			else
> +				sb_flags = sb->s_flags;
>  			if (retval == 0)
>  				security_sb_reconfigure(fc);
>  		} else {
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index f3238f38d152..48275fdce053 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1796,9 +1796,11 @@ static void apply_cgroup_root_flags(unsigned int root_flags)
>  
>  static int cgroup_reconfigure(struct kernfs_root *kf_root, struct fs_context *fc)
>  {
> -	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
> +	if (fc) {
> +		struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
>  
> -	apply_cgroup_root_flags(ctx->flags);
> +		apply_cgroup_root_flags(ctx->flags);
> +	}
>  	return 0;
>  }
>  
> 
