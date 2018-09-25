Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189E3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AB420867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QVyTvUFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AB420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeIYMlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:41:05 -0400
Received: from mail-bn3nam01on0048.outbound.protection.outlook.com ([104.47.33.48]:24593
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeIYMlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOOxcZx5JRUJTq6o1YAkCYiGZwmtQpBux9AHeP7eP4A=;
 b=QVyTvUFjcS1hI/Ff9CSCDCFqJ6eyp8vI+ayj5CF3hdMEixD90LWgkxPa2g++JU3qW+6V7oyNOL07N7/VGuL4I0jk/ZWIMfIrRaxYTX3Wz9lZBXYNcl5aTs+BFoLvWk22aCtNWqzaqzl2cDCYTKd00Xr2M1OfWaiD2DWz4C9VrZo=
Received: from BYAPR02CA0059.namprd02.prod.outlook.com (2603:10b6:a03:54::36)
 by BYAPR02MB5109.namprd02.prod.outlook.com (2603:10b6:a03:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Tue, 25 Sep
 2018 06:34:42 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BYAPR02CA0059.outlook.office365.com
 (2603:10b6:a03:54::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.20 via Frontend
 Transport; Tue, 25 Sep 2018 06:34:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 25 Sep 2018 06:34:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g4gvh-0005Ux-HA; Mon, 24 Sep 2018 23:34:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g4gvc-0002G2-Do; Mon, 24 Sep 2018 23:34:36 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8P6YXvZ032378;
        Mon, 24 Sep 2018 23:34:33 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g4gvY-0002FG-Si; Mon, 24 Sep 2018 23:34:33 -0700
Subject: Re: [PATCH] net: macb: Clean 64b dma addresses if they are not
 detected
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        "Edgar E. Iglesias" <edgari@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <u-boot@lists.denx.de>, Joe Hershberger <joe.hershberger@ni.com>
References: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
 <20180919180806.3tps6yukhm3ry43i@toto>
 <7e641346-dd4c-4e2a-637f-1b666f13485c@xilinx.com>
 <20eb98a9-edbd-c613-1f76-eccd7e06e052@microchip.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <af9f6deb-08a2-4c94-9839-ebe629063e6c@xilinx.com>
Date:   Tue, 25 Sep 2018 08:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20eb98a9-edbd-c613-1f76-eccd7e06e052@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(356003)(426003)(186003)(446003)(2616005)(77096007)(44832011)(36756003)(26005)(229853002)(11346002)(486006)(64126003)(53546011)(6246003)(8676002)(126002)(76176011)(2870700001)(31696002)(23676004)(65806001)(36386004)(47776003)(2906002)(336012)(65956001)(2486003)(63266004)(54906003)(478600001)(4326008)(93886005)(476003)(106002)(110136005)(9786002)(65826007)(316002)(106466001)(5660300001)(58126008)(305945005)(8936002)(81166006)(81156014)(31686004)(50466002)(6636002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5109;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT010;1:NzRB+aoA6VxH9ebpq4ifcksnB+FoQlmRLJv061lj3QwzyRkXLuECTg54/zqotA86RFfABY88PL62X2xexRifykFRKte4YCkkGRqmUDGA/f5D8VwkqV5uTfIQGanA+aF3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cfa4d9d-1457-46c6-80b6-08d622b0f9f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;3:qL8mZ96rFwIh+cmifvTun+JI47Po+xFBSHCn4mEc/tTUDQMIclCkkWQ3fPr36HOucr1o0ZAjTK9M37x6yWiUcxke+2PnXNypqQ6mIzhBu0OAg1kpwVqPgtzvQ3z9MlqUB6vI/tv3Bp/ct0yjA2pFYummstQ7NA3M2AMgU9/c+5T7zeBzS+SbQW13Admqdg/SIhVQNblJpWO0iVtNzyushSRIx6DSegA200SsoxRjkFJwcqwNMpEHxi1D1VA8ZyegK7P9yx59z17QF2JUUrgSYZcw2Gg7sMoXDkLZfOsTFNgvHrE9rhAmbWC7QpZvHJPAW1Y87HuY60KPiWtEIMVrDP+5FlPc8+D1qiA4TdQOCw4=;25:3YpXw/3iZhDuYtm3dnJ+FcVWUvEQkob6XP7FAZbv/q1W+sMpr76rZMyvITYSboF29w5DHTWb5GsNw929Z8w0EOG1cgtJFhY0Yo98JCX3S5+jAFWZsV5aP2uaICQosDuQXT281o/qjVQytFJsoag5Wk6DBoLBTIWvKLIP7MROQXJGZLoTWJXqcrU9Jz0qSpw8M62t8yMe160VUq0nNlfUleMCxjKF9logTrZ8jWmbjqa9YJQZsylQ1ZbQw+r5IsKcumTJwBq+jNYJPrAfo2cDLJ39Vn3weokwgk4TYZjgaivt9Te5I5brhJxDlAvR5t0kFbQaluol80ujR3D9P2S9Dw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5109:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;31:umPR6wFQgkWh+ZLFqppZ3Jlj2SPWrIDmyaiNcpteDC8GsJnYHtLES1vlG+kFQ5w7sXohWo39APcFUypVTJpJEaAC7GIth7tAf4M5UsdZhzEB+zAX5rCrt+IQh+ASkpIesBMV8GnCE6dk5mH5mBRrGeaIY2NpNxcAM1IIdTf7kV5QLmBFbL8VK1KY1T73IWrL4U1uhki1KPQN3aHBFqTf1fqHsK/79x88+xbhG+Qsui8=;20:MMYBwuHYdpuOGnW3pImAAjSJHM/BxUIwFE5MKtAQkzP+mSMOKnjXhKp0REc4NwkgoWJyPSnwhbgmbEVFIXPs4nYi0uDJWmYgBcX3z6Vjj8zSMwWMwcBRO+H1OYDYcxe3EcP/RKs6x2m80RTywQtkevOBeNqtGc+3kpFWG/l58y4ivsYzOzej2xCcWma5xBUB/0iSRQpsOvmYWi/GAWcv+ttx7jqS16Y6NulnfEEGRE/go6CKZhWANPJBCdlhi7YCel0Z9u2P+Vljtjapi8gIZrPLvyGIFImIqvJ4Gq6gdf8BS6vEYUjC9caJQ6Mrq+qMkhORo8U3H33+Fgq1N96vc9e4+0uhSOcELj4KiwjoZN6fof37KvAa9JSX5VC+NvIWCTWDh0Rn3rehQiCMj2qTQUtbo6h2YIXd+gW1haj+ovjgTr0gmruLFxYJF5ERPvT8Hns/H/x/Y7gIG9qe1bUd1WKEufXZZlZzd/XenMZrfy18Al153rx/PUMDAZa9OKJJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5109AA23090CDD80395B5585C6160@BYAPR02MB5109.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR02MB5109;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;4:lsvlaQ2rR7v7qIIuo28hmVnM4yAXOsH2nu6rzLxT0ln1uE/uAJ90cJv3Etxh78Ha0/0qXFU2hIesDi51m1Hfei68rMMoLjIxwvxP7UMVhINyGMbjJgQSsBmadZ4wLm50OjvGOgDREI4AXOfwJk6DUVdhWtaWMUGZ2EOyYGZ/TTk+rFVgM995rkMVyGb++ui7+tQt7e5KxzhsIjBIeUG/6deNTvgTRlGvevfufzCiu5cFYnMIos/R2DWINpPX0pEvk5hjiyF3YES2ABHr+x6Kl/bDH1O+9x7iNS+3wq44TbZoeqOeA1PJLrITlWcIFkHz
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI1MTA5OzIzOlhmTnZpT3lVd2RXbStMdmJDcXJCMTU5NDkv?=
 =?utf-8?B?eGNFNE4zMVJwK2pPS0RVSDFJYXNXOVhZcnRGeUt5NnF1L3VnUGxNV0FPRWtn?=
 =?utf-8?B?MmtqVTkra0RiblRVR3laMFZadFlIK0hCQndXeGRaRm5tYnpUOHR4Z3pETHpB?=
 =?utf-8?B?LzN3YVhrb2lFMCtBaWowQmRneDk5Nk9zS2hxblNuclZ3alFzVFpVLzdNQTE3?=
 =?utf-8?B?K0hmcWV2Ry9OS3NjTVltVERqS3ZPb1dRRnQweUJ3VmMrbkpaOUZtVDJsSk11?=
 =?utf-8?B?TWRGMTJKODJldUg3Q1laRXdzZUdMRnBleERrL3oxT0R5ajlkaW1CM1dJUEVq?=
 =?utf-8?B?WkhuZUpzZk1SaGdqbXpBRkhOaksrSXZlejZ0cXpEcjg0eDloTEtuRFNVeG5Z?=
 =?utf-8?B?c3V2M3pDbHVkTnE4YkttVThRTUVlZHRDb0ZCSVlZYVRwOWdlRk9LQWtzYm5D?=
 =?utf-8?B?aFlYL3NlZ044WGFHZzlQWWNaZTlRVUxIcGxpSmRyMHkrQzdRRVFZMVdFOHN4?=
 =?utf-8?B?UVF3bzJyL3AzOW9EbVRzMzRGS01MNmQ5R1QzcmlvaXpST2o5MHVlelVLKzg4?=
 =?utf-8?B?Skk4MU9qU1d1OHZZZEFRN25BM3dFS2JJVWw4RnE3bzJPaGFCOW9pSXBFRENi?=
 =?utf-8?B?dHhpL1V3MXJsd1VIcVdvRkc2d3lqc0pHL3lnckIya2pVRGZvZ29PVWhScGtn?=
 =?utf-8?B?d1hsTzJiMFgzVkczaXlCbDQ3VStaWkZvOVM2QW9QdXVqSGZVenptWTdHNS9K?=
 =?utf-8?B?aitBa21PK0NoYmpNZzNoWWNJczVkSzNJSjh6WG80TXpRK3l6bTN1b0RkSm5h?=
 =?utf-8?B?U1I5WjVLM1dXSUo5MjkraDBrSXFheVVhMS8rUERuYVRTNkwza2dHZ3U5LzR2?=
 =?utf-8?B?K3Q5NlJ3ZWVlMmJXWkg5RjNVWHRZQzl5dHk0a1ViVmRLTzg5Y01ld3NNdlF1?=
 =?utf-8?B?SXpzWnE1dlFhd0djOFprb082OFRpZWlLYXA2aUx5NHhhY05jejNhZHI1RFpz?=
 =?utf-8?B?a0xHZjlobU1PZTdsSE9rc002dWtwcmtxSlR0SkUwdndaMElrYUNOM1VwQlh6?=
 =?utf-8?B?eGR1MzBFa0swZE1oRmkxS2NWZ3Z5dE4yTFdaMDcwY0NlZm9lRmxlbU9ZRDM2?=
 =?utf-8?B?RXhtYjNCeWtISHpzWFJiZlBZRlB1VmlUTTVjL2VvY2RHSlQ1NFZrRGRESWN0?=
 =?utf-8?B?dnNPUVRYY2VGeWdWWWVBZis0akZCRnlkQkdsNFV4YTFFUFdtbk9QK1VFVzYx?=
 =?utf-8?B?YzVzT0V3cHI1bkN3aW1NeGp5aktLUFUxNDVIdTVmcks1NTc5V09vUzR4ZHFa?=
 =?utf-8?B?d2hnQ2ZLbExDZU9NdE5PRU5SMVlnWU9MRFUwbDN3d1l6T2xlbjU3cmsxWXpO?=
 =?utf-8?B?YnJJL0tCNkVFU24wc1BFSDBJdC8weWlVWDdPeGlOQm5OWGpuWEZrWUhPSEpX?=
 =?utf-8?B?K1hMdlJDTHVpWjNacmlMcEhvZkdzalRpd1RMVUJzOHlkNFNmcUdOdmpLV3lx?=
 =?utf-8?B?QUxka2tTQ1VYZjhXSVc4bkNZWWViTEE1VFNXZndLdEcyU0FBbFY2WmRyeTNY?=
 =?utf-8?B?WDVnK1lvOVQ5emRpRkFoNngra3JtcTFsUVJyNy9kV3BJQ3JuVjRBcDV0RVRO?=
 =?utf-8?B?N2wyUS9MMHM1ZmtQNm9TMzR3azJvbzR3NEwyaW9PbVQ5WDRTZitRUXFKL1ZO?=
 =?utf-8?B?Wm1COTdTNWtpdi9HdGxjREt1OEZJcGwralhJVTlUNWgwUUp5Tkc4cUxXdjNN?=
 =?utf-8?B?N3k3Szg0ZzVJeEVlOUlLQT09?=
X-Microsoft-Antispam-Message-Info: +7yYlhXXK8XcCypBas5RkFAdzGDZbeFOGT4KeK7UQvRpqwJ79hhsVputIJEuUEPQb0T5FfH1pRZqleQvclbjIVDKjS4BqmcH/CvCoSDF+vqDtTzlObnyGGgubJaCiftqFhKgoCaZMBQAPd4Gm5iIMN/90TIysqUdH/M2fwmQk5t44f2ivnk1XrK/vmcbE5uRGhT+ucuavu5e9vqNhi7ZRJ80w/EmbQtOwoJiQpfYm83HF+5KAC48C8OlEtufz1gi/Ha3ma+3ZqgmGlYWYslwF6pBPnb97eZ3sqB0cQMz9Gl8n14W+SzR0i8a+GdYv+dQsJT3WiKsgGD3OmioHUdH0JRjV2QMa5c92IGSC7WWRvY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;6:TBJalMh9Fl1OydHekKLMxWDXGpkqWnEFqglktVr4V5SoanZwLi0cIjP1Vtn3wt3OqJYw2hd6bzM0xjxAbhJqvB1T5CNfS/xnVHbImc995tEvE6GQ0A8tVNSoGPo4UYI2dGq0zqTTLr7Z+Xy+dSIuVINdO9NyBfHnKgRVjTvDM/m8dQmfsvInSczk8H2ogX6XZoO4OvYPrViys3gBaDAbFuEroh2apZti9IfLa7Lha7BD9EPr935QL2by0VpXzPnUZQD9SsI1QBxYreguhO4QoIp5RqfA8ynqJaqgukv3OtWQWYZygjgpJ1msZjLwoJjzTeNMN2dG623xjjiQyu66Ha5r9HKDmA+3Ys0wfIXnFeOrlvMAtKqwUA5OXv9erf6X+gHTjh0Dh7K3ttOQV00zim2Z/0QQXEQ1worG76KJn1jz0pYEP2q3v+hd3D1/aNVJU9FFakJghz4N2j6CtTG84A==;5:1GiSotzm5sExGDatC+7vke4sRZCs7yiwXnlS9aNF9Dgqft5VvLnIDO6Q+4S/cQ/nT728kdxu7EoIADof/XEnYK4OJTa4C6zcf6FLC5tjtgTUi5lHkkRZaCHygfITqBFOBvw+Epm5IRxHlEWdUtU6rZXs1uQE05TNf+0/oSQSZrA=;7:YzqiPwey4PU1NO0VGLQWeAXMnVZxlakrlWTL8p5bwqf358y3nXgPJ+LDWn1RYDyS9roR84BeSSYDxT685vG/7MhFx/bqY/vbVPnZerenDtJi0pHfRO13c7ev165LQXphCobODLZ05pgHYpJ9+/jufLKj9mE1qI1t9kf9GG+7HyCPmkEh7X7eqEoHj0/CPaTG59E979bonIH9dxFu/14dh788M9vbKUy5YBDVwkaV22hK8abOoxec2t7lP2CFhSap
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 06:34:41.9114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfa4d9d-1457-46c6-80b6-08d622b0f9f5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.9.2018 14:38, Nicolas Ferre wrote:
> Michal,
> 
> On 20/09/2018 at 08:23, Michal Simek wrote:
>> On 19.9.2018 20:08, Edgar E. Iglesias wrote:
>>> On Wed, Sep 19, 2018 at 06:08:18PM +0200, Michal Simek wrote:
>>>> Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B
>>>> is not detected on 64bit system.
>>>> The issue was observed when bootloader(u-boot) does not check macb
>>>> feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
>>>> by default. Then macb driver is reading DMACFG register back and only
>>>> adding 64bit dma configuration but not cleaning it out.
>>>>
>>>> This is also align with other features which are also cleared if
>>>> they are not
>>>> present.
>>>
>>> Hi Michal,
>>>
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>>   drivers/net/ethernet/cadence/macb_main.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c
>>>> b/drivers/net/ethernet/cadence/macb_main.c
>>>> index 16e4ef7d7185..79707dff3f13 100644
>>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>>> @@ -2163,6 +2163,8 @@ static void macb_configure_dma(struct macb *bp)
>>>>   #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>>>           if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>>>               dmacfg |= GEM_BIT(ADDR64);
>>>> +        else
>>>> +            dmacfg &= ~GEM_BIT(ADDR64);
>>>>   #endif
>>>
>>> I think you might want to do this clearing outside of the #ifdef.
>>> If CONFIG_ARCH_DMA_ADDR_T_64BIT is not defined, we'd want to make
>>> sure the ADDR64 is cleared. E.g something like:
>>>
>>>               dmacfg &= ~GEM_BIT(ADDR64);
>>> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>>               if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>>                       dmacfg |= GEM_BIT(ADDR64);
>>> #endif
>>>
>>>
>>> Same thing for the USE_HWSTAMP/PTP flags below.
>>
>> Origin patch, which introduce this read with mask,
>> macfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
>> was done in 2011 and from that time this function was extended a little
>> bit. I am even not quite sure if make sense to read this reg and apply
>> setting on the top of it.
>>
>> Nicolas: Isn't it better simply compose that reg from scratch?
> 
> I have several arguments against composing this register from scratch:
> 
> 1/ the reset value of this register is non-null for both of our
> platforms and it could be meaningful to keep some of these values.
> 
> 2/ one bitfield could use different values between Zynq and AT91: RXBMS
> (1kB to 8kB for Zynq and 512 to 4KB for AT91), with same encoding.
> 
> 3/ and well, this is the type of register with multiple bits that are
> marked as "reserved" and that experience tells that they might be
> connected to something...
> 
> So, I'm all for correcting the code like what Edgar suggests.

ok. I have sent v2.

M
