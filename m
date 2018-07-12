Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B6EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A09213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ud+S5Uqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A09213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeGLL27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:28:59 -0400
Received: from mail-eopbgr70091.outbound.protection.outlook.com ([40.107.7.91]:53057
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbeGLL27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4jimcZ0HBFyHSlfKPT45QZ67qO4KQSbasjtK3NI9s0=;
 b=Ud+S5Uqcv/wQ5m6dMjubOSZavCd4uh6GyORbO6dm6/C2r/Lz56R6mfolSd0bb6qJUx4WTXCRTGTX83T+QKjwaZV63J12JjgWZyhwr1egZHXXqNAH2hzw/YndsiZDISAO4ZvHLO3UZgarWbHC4WIP2xoKxtX2wK5Sn25mhoFSCoU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2021.eurprd08.prod.outlook.com (2603:10a6:4:76::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 11:19:39 +0000
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, mka@chromium.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Wilson <chris@chris-wilson.co.uk>, longman@redhat.com,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
 <a9fe3e9e-a1b7-ee19-35e6-af32b5f25a37@virtuozzo.com>
 <CALvZod6eomn1Mt5r28tMthq4b+3MWuWJKgishf_N4UjortzvHw@mail.gmail.com>
 <ed6a04cb-6164-bfab-f2ff-8813068e2e95@virtuozzo.com>
 <d1fc50d1-8a64-a118-7040-8ae5606d411d@virtuozzo.com>
Message-ID: <581e75d2-0f13-b1c7-adfe-7e873b984fe3@virtuozzo.com>
Date:   Thu, 12 Jul 2018 14:19:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d1fc50d1-8a64-a118-7040-8ae5606d411d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:50::15) To DB6PR0801MB2021.eurprd08.prod.outlook.com
 (2603:10a6:4:76::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deb105ee-37d7-468e-2595-08d5e7e95d73
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2021;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;3:k587EnNiUNXrabirBwWPbXmIGDilw2zZW/7N9327g/+sPtLq4ZWlwxjoP4zSSiIN+qM1EG/t3LXrtfEyOKowlczaZazCpLhInzf5F/6/WwlFGKJJ2CYltVGyLYet7PPLTNVumz9Ov+FdpazrILoxxb/1ubSCOZd35G7BH6LJSVSfuwUrDEhRdRXNeAP7QAq/vrin/vRmO21agLtTLxMmUsOp1pkdU2kg7uHRdX9YNmpUG/Z79Bg0E+7zCaLT+90q;25:vHVmQa9YRDRpYCKMrdHZCq9Rz3mrQj9PY7UqFtUvFjZVuXRNjy/65rNv8dq5KskJuRxIVBmG/92fB3beivL34aD5hbl1hmd/mMQ3364V7JMQ0ncDYH+eGobb2rWh0frU//CIiUEuRcC/wLgcw2gNi6zqifJHTdfLfbhIabtOc/oS37YA3cF5Y1t3zG6tIS1XJVQAN47Lr1l7mNUHK4UobqP0AGZY5YUeyi5/lUKfNxnOMSZOq42UhuoiCZ9NdKtlLtvetEAQ4TGv6c7XilTaDtUs3azpMH5a/TYbfVKMGHFuxChYvhK5c+7QDmaTgs8v5hNo6X+3mugUCR6IzPnwwg==;31:LG2SWcIlyxVYjCHeLtBwOVecpX0OtRhgl+LYtYGT5Bh9SPSHxDg4XSQbXBZoVdUeH2H3Z8ZWCwkj+7yHhBQYPFniFBi61EnXtCFI4l9zTCUckLiKxViFA/ON98GzOjbdOXLdhSAsei0MYYKLboC8pneM0eVq3h2JOPXWoEmTdSprNTyQbbeLqEWXf63s7Rse/go/A5JiwJcx8AFvlJp160PB98r48jJ/TCCQ4tJkUUE=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2021:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:VNggE4KOu3dNP9LAHMGoB5DnEMvS3iZuSm1ko8PGPrs0xztxqQrWBpAOVlCgxNKvWKzSbtzGPD7HxnF2E2rvB9pY4s718+kkgTpWGm2PQRU9M6sWuoLKspiXuukGZVp7x5l8sqaVWdaDmbSjSXRVJEBmzkZ/SX9G3brIKlJhAB9ssafzEidyNftPYyIwgUOPvmyKdTp9bFoQGTewEs+0p+/qaezYOXqHj9u0LM2Etbi4pfWd9q817BXolkRVw+cGsybLJnLG4TE0Hp8gkMLvBQ0OxHxIxoNgkuO+gnpYQGFY8bX6STrkwzDUr8jGvaLE5jIu6SX5D84JjY55XKc0FWzWnPvvf+xjJU0vJZZK6xMEaCEuB1o5Ilj8y1YB3je6XkfsCGoONXGqApQwj5dOAqJ/4sDNMRj/TcQx+wW8gFgFwmn9hMujoJn6ED2COEDkdMcMyBD760nA7nTAOOlyQyZoTDpjRT77RQ5UfXPo4c5LDGmtHHLlznwuhgFwny9z;4:w0rQUjo0qrkfOms8BLuH2tCIdW563hcPPaWSlXzTVaMC5FVdFHjOCZCihPvf00874YCr/SpL69v64CYsVvvAlr15JTjjSffx1iWHohhd17VZ7sYvnWgUeL+sg9OF69uDBR6hyj+J2vfp9fbS2/UbdGkSNlxQGqSxg/0A0iXwIs76OLaUuE2SsDt+922mZvoof3Z5W4HceghOcGSvwj2I5G2APbd16CA/MAZZ9zSDg9rekyyNwlmF+LOycnArChgr/xAmDWm+BWpqCwhLNN23Vpq/WegiO+fApDvXmAPRY4hC07VKomgNXcImgqtKypJU
X-Microsoft-Antispam-PRVS: <DB6PR0801MB20218E4216F8014E0A2F261DCD590@DB6PR0801MB2021.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2021;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2021;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39850400004)(136003)(346002)(366004)(376002)(51914003)(189003)(199004)(478600001)(7416002)(966005)(66066001)(316002)(25786009)(65826007)(7736002)(8936002)(65956001)(47776003)(81156014)(53936002)(81166006)(105586002)(8676002)(31686004)(106356001)(386003)(54906003)(53546011)(64126003)(6116002)(16576012)(58126008)(77096007)(5660300001)(186003)(16526019)(305945005)(26005)(65806001)(230700001)(23676004)(476003)(3846002)(52146003)(76176011)(52116002)(486006)(2486003)(11346002)(2616005)(93886005)(956004)(446003)(97736004)(68736007)(50466002)(6916009)(31696002)(39060400002)(2906002)(86362001)(6666003)(6246003)(14444005)(36756003)(4326008)(6486002)(6306002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2021;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjE7MjM6djBzUUhCNWpmRmdIdTV4bFJLS2IvRnF0?=
 =?utf-8?B?TVF1N0NrSzF2YXVsRWNDZlVGM1BqTy9BRTg3cU1mSnFVSTlEMENkR2lqeDk4?=
 =?utf-8?B?ZXFPY2FhVmJLWW5zZ0M0V1cwc0NkR2RKZzUwQjRzT3Y3RGNaVXlrK2dabmNz?=
 =?utf-8?B?d3BhS3JtT2ZybE1wV1NkbjIxTjIrb0srWW9RejdoejFHTG5nblVzVWc0amds?=
 =?utf-8?B?R2JWL3NPSVRRbjBTRGZOMzlYeW9NVFNydERhRTJXQjBqOUlUVHhJSjRlY1E4?=
 =?utf-8?B?SGd4bkREd1E3YTMwRjQzT3FVS3VTNlprT094L3UyZERVbGdYVU1TbWN1cXZR?=
 =?utf-8?B?RHNmeVA1R09yVEd5VTlHK2tGakhpV2o2eGFaTEVvbFdSTGtoa2UzaCsvL29t?=
 =?utf-8?B?V3ZKS3B0dUhYSnlZTERPbzZZWUZPL2FxcEN3NTJWaTgwVkwrdWFFZW1FM2lB?=
 =?utf-8?B?Q21MR3pkajJpbzJFcEUvNmQxQ3E4aGpJSVZDckNqUnVzNUtHeEFpaUJoSjVM?=
 =?utf-8?B?UEExd3ZoUFpIamVoNUlsVVBVMDBMSHFkZnRic3I1TVpyQ3MwYml0RGNTVmdi?=
 =?utf-8?B?NDlkVDBjcm9xTS91TWgvamluVDdBcFgyY2NsTjRESTBza1RoM01lc1lXbFU3?=
 =?utf-8?B?aDQ5Si9YMmJJM3M2b0JTQXZjQXBlVlRFa1dIN3ViNDlmaktUNTlQU1hQUDMx?=
 =?utf-8?B?bWs5N0F5YyttdlZYblVUMXV4WFZ4S3V0VmFISWtlMUJYNWR2dFJibFp5MkpP?=
 =?utf-8?B?eXkyb3AyNEZMbm40YncxN2hrMkNWM1NZeEE5a01nbVBrT2dWL0l4OFdpaTBI?=
 =?utf-8?B?WWx6MzlTakxJUTVlWG9ZVWlqY2RadDhYck9PaXQvdnNUcEFtZ3JoR0ZFQ2hz?=
 =?utf-8?B?TWVtUDAxUDBzSTJvSkwrL1FMc0VaUyt5ZHJHaFROazdERHQ3ZGVxWUcySDNK?=
 =?utf-8?B?WHFHajBhMjZzMGhJTWNNYmdjV3g1VkVqTHc4cW5ndk5RMEZaTVVEWU1aNUhS?=
 =?utf-8?B?N2Vleko0TURpUEFEdHNYem9tbGNkQnpOV3dUYS9QTmlpSXRoZ0lYMVRwRWty?=
 =?utf-8?B?aVJ4akZnWjVWdHpPeDlBNU1sWEZ5bFNuZnZDR1FvM2Q0bjZrcmxnNjFIcmZu?=
 =?utf-8?B?MVhiaVdRZFd6M3IzWUFuR0JpRVlOaVBvcnlqTUdMV21Fc2tVME1NWEx6YlB0?=
 =?utf-8?B?bXJTUVBjcWNRUHUvSlUveUJKdkpaUzEvaWZKRWFOcTU2L3dMQjlHVmFSSFNs?=
 =?utf-8?B?VEhyNnR5RlR5REZqWVdqdDNhdHF1YzZYRTI3TWJReHRHczh5ZVNjcVZDOXlU?=
 =?utf-8?B?RkFiMG1QMnJrcWlvTGxCWUtjZmNDaXBzT2p1dWlQSjBERnl5M21mZW9xd1d1?=
 =?utf-8?B?RUJ1T3dneDZZRE4zVWdJTTByTUhRYWJFZ0ZyOFliblhNQkFBdWJjTlFoSW5T?=
 =?utf-8?B?aWIycVhpZjhRK3FZVll5TG9xbjIwV0FHNysvK3NBYjBKb2RQMG8rdUpYdEdB?=
 =?utf-8?B?R1BZVERGalZVaTJudmxNdXFWUTNkcHdkb1NTYnhsUDZtSHV3Rkc3U1g1eFdW?=
 =?utf-8?B?dnJ1NjJLWWlpSGUzUllvUmZqNkVUQ1NwdEZHUkgvMmhLUWRnRWtLUWVXY29M?=
 =?utf-8?B?dTNqYm9yNFBqREE5QWpKQWN5M3dHZmowVnJsMUp0NzAra2NzU0RxaTE4ZCs3?=
 =?utf-8?B?dXk1ZFpyQUdJRjIvb09mN0UvS3V4Q0Nad0FHWG9CMnE0LzVDR25YTHE3b2pE?=
 =?utf-8?B?dnh0Zjc4WVZDVDA0YzZhZkk0MEdIOWZDOFlsZEwxWEJEMEUxNG02dDBnVmFp?=
 =?utf-8?B?QnFPdW1lNC8rNGdmTDAzUENMSGNzMUFKOEZORU5ZUGxJdm5PdjhBT1hsclhm?=
 =?utf-8?B?dlgzTVFPdGl3RmVVRm5xMUVnTE5zSDBsSk9TdzhHenpQRytXRGo4TEpHaTBR?=
 =?utf-8?B?Y2ZBWG56b3FPRmVaWWVEeXRiSzJYVmFvdUFQeTBqMzhhanpnNVJnTVlaWUR3?=
 =?utf-8?B?TUl6OGg4SnU4cDVnYTNseWRFaDBYSzFNUkNYYWVmaFRZa3dJbFlyV21jc1hQ?=
 =?utf-8?B?M2gvM2JyQ3BsUklJMUxFMnBUS29ydGsxR09id2oxZDJ4U0p5U3JRMk05UGZ3?=
 =?utf-8?Q?FIOOaHLTz0e9QtoZonVFuw2AI=3D?=
X-Microsoft-Antispam-Message-Info: OZlVnrFrtQJx/RuLGqOfwJfbx7KcOe/6GhzxvP/jDRgABy7ga2fDb2q721pfcv41wp2f59fq19yJ1CQG7xqHWjhE2RHe2ASwnb3dq99jzdnLFOnHMNCp7uOvsWpa5P/5ldBZp1brpNznz+yjGn+19qv2IR4muI0/9qJYJNSSy9jGNqv2LeDNC+A8SSaXOH205NMR7MvQD+DDWqs352htujLFu+EHt05gTAExmYnJ63SxFcApv5bysHg44uaKkRMjkulkSUCzmwVUOmr08/PFoeFfcQswMopJs9NGlMvCfF1nWHhy+h0ab4NeWImO9tTPu7No+5QnoJo+cokibVe27AA2+7rBPQpvxetCu0XaIiM=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;6:o5cFUvQXhU6pROiFwvKYZucHpyDzzBBNs16DC4uJopYKe9Wqu8N8e2tOUgRhp8708fka2HJQ4sdjTV5qVYgJ0DNuBN62jRzGKlrQUkGQxdzSDQTs458UpYSkphbqAdaCqBbyPks1JefURtfurM7AoUi3vRbQqWhRybGVLr2n+xrcLBSUDJhBKeCpqy4l5SugQDH2AQNkWA3R//g2aAeMIhBcsyOUddlp1tDAbT54AzUr0Q02+4uZCqbhoYqJ6MmzvkISzmugNakzuKXjMwh0ubx6lM4Vx98VNGjkizvqCLnvN2R99Z+ICyT69FkaIdSzXJpLOCFa+HjFgFftx54DGkF5J8a93Ox8fGuiOwQcRLbaEc22qYhXxQxwd+uqw9ZXutIukIEVty8XsfsRFDOvt0LV/4GU8fIcfVfW5BhPvBFN/Uoy0uuHg5LA2IaZnDJIdAg47954FIbuITuu+pqHuw==;5:RNVly17nfGVkEireHEq5zA5MMuzfOoTLorqawInmqxqhvt9L9WKSXgo9M8epmgKq6PaXOqqENwnjF8AzXJPAXephjn+jBHRUckdRwHvFrSMm6vyGENDXuDk34YZD7gB1qwphNNz6ZE8EiqD7rWjqKmso743UisQl4uEgZqSG6uQ=;24:kBwVEl0wNID4OxMBbHpA3z2uHos/f5/FJRcvZ0Jm2Tq00+JJGLmI1YvNG2ekfer70qpcANTTGISws0oQwo2AXdJJM4ZVY9UuRsSUBalIMmw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;7:xQX0/6lOlPTrKERP/wajdkmBhjIWMeiNlse3V3VIFig6F8j+l+B6ljolwPAo6bXHyC9XOZsYZG8TwHopbdpa6c0AzucTmcpRH/BuU3hY4gJKcVxdQdUfJsuTueFJjGjqnQlKrkiyRfIadXNB7j07YQuUKpUFNeGY4B+Pp+J+dhYWc5oxxym+SLz3TLU+j4ro4up3WQrq/7ROfe2Aq52aStftz2FLnlyvh6UEPKllPiAg0/ccGd7us+xFDVmi4cc1;20:s//XVgFmJy9yAgjVdLnyk3D0j/7C0c+/zf0aVLs6xW+HoDi5uZQvogvCEPlO8XKOcSfLR4hoC4z8DIh63D0NvlO+UFOpUOJkxyeI7bZOWuoE+B5bzI5OWNNAVX5c1HqkvAzuwRDB746piVFiZ/DV3nLZL4j/xMT3kJAbYoehqBY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 11:19:39.2960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb105ee-37d7-468e-2595-08d5e7e95d73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2018 14:13, Kirill Tkhai wrote:
> On 03.07.2018 20:32, Kirill Tkhai wrote:
>> On 03.07.2018 20:00, Shakeel Butt wrote:
>>> On Tue, Jul 3, 2018 at 9:17 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>
>>>> Hi, Shakeel,
>>>>
>>>> On 03.07.2018 18:46, Shakeel Butt wrote:
>>>>> On Tue, Jul 3, 2018 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>>>>
>>>>>> On Tue, Jul 03, 2018 at 06:09:05PM +0300, Kirill Tkhai wrote:
>>>>>>> +++ b/mm/vmscan.c
>>>>>>> @@ -169,6 +169,49 @@ unsigned long vm_total_pages;
>>>>>>>  static LIST_HEAD(shrinker_list);
>>>>>>>  static DECLARE_RWSEM(shrinker_rwsem);
>>>>>>>
>>>>>>> +#ifdef CONFIG_MEMCG_KMEM
>>>>>>> +static DEFINE_IDR(shrinker_idr);
>>>>>>> +static int shrinker_nr_max;
>>>>>>
>>>>>> So ... we've now got a list_head (shrinker_list) which contains all of
>>>>>> the shrinkers, plus a shrinker_idr which contains the memcg-aware shrinkers?
>>>>>>
>>>>>> Why not replace the shrinker_list with the shrinker_idr?  It's only used
>>>>>> twice in vmscan.c:
>>>>>>
>>>>>> void register_shrinker_prepared(struct shrinker *shrinker)
>>>>>> {
>>>>>>         down_write(&shrinker_rwsem);
>>>>>>         list_add_tail(&shrinker->list, &shrinker_list);
>>>>>>         up_write(&shrinker_rwsem);
>>>>>> }
>>>>>>
>>>>>>         list_for_each_entry(shrinker, &shrinker_list, list) {
>>>>>> ...
>>>>>>
>>>>>> The first is simply idr_alloc() and the second is
>>>>>>
>>>>>>         idr_for_each_entry(&shrinker_idr, shrinker, id) {
>>>>>>
>>>>>> I understand there's a difference between allocating the shrinker's ID and
>>>>>> adding it to the list.  You can do this by calling idr_alloc with NULL
>>>>>> as the pointer, and then using idr_replace() when you want to add the
>>>>>> shrinker to the list.  idr_for_each_entry() skips over NULL entries.
>>>>>>
>>>>>> This will actually reduce the size of each shrinker and be more
>>>>>> cache-efficient when calling the shrinkers.  I think we can also get
>>>>>> rid of the shrinker_rwsem eventually, but let's leave it for now.
>>>>>
>>>>> Can you explain how you envision shrinker_rwsem can be removed? I am
>>>>> very much interested in doing that.
>>>>
>>>> Have you tried to do some games with SRCU? It looks like we just need to
>>>> teach count_objects() and scan_objects() to work with semi-destructed
>>>> shrinkers. Though, this looks this will make impossible to introduce
>>>> shrinkers, which do synchronize_srcu() in scan_objects() for example.
>>>> Not sure, someone will actually use this, and this is possible to consider
>>>> as limitation.
>>>>
>>>
>>> Hi Kirill, I tried SRCU and the discussion is at
>>> https://lore.kernel.org/lkml/20171117173521.GA21692@infradead.org/T/#u
>>>
>>> Paul E. McKenney suggested to enable SRCU unconditionally. So, to use
>>> SRCU for shrinkers, we first have to push unconditional SRCU.
>>
>> First time, I read this, I though the talk goes about some new srcu_read_lock()
>> without an argument and it's need to rework SRCU in some huge way. Thanks
>> god, it was just a misreading :)
>>> Tetsuo had another lockless solution which was a bit involved but does
>>> not depend on SRCU.
>>
>> Ok, I see refcounters suggestion. Thanks for the link, Shakeel!
> 
> Just returning to this theme. Since both of the suggested ways contain
> srcu synchronization, it may be better just to use percpu-rwsem, since
> there is the same functionality out-of-box.
> 
> register/unregister_shrinker() will use two rw semaphores:
> 
> register_shrinker()
> {
> 	down_write(&shrinker_rwsem);
> 	idr_alloc();
> 	up_write(&shrinker_rwsem);
> }
> 
> unregister_shrinker()
> {
> 	percpu_down_write(&percpu_shrinker_rwsem);
> 	down_write(&shrinker_rwsem);
> 	idr_remove();
> 	up_write(&shrinker_rwsem);
> 	percpu_up_write(&percpu_shrinker_rwsem);
> }
> 
> shrink_slab()
> {
> 	percpu_down_read(&percpu_shrinker_rwsem);
> 	rcu_read_lock();
> 	shrinker = idr_find();
> 	rcu_read_unlock();
> 
> 	do_shrink_slab(shrinker);
> 	percpu_up_read(&percpu_shrinker_rwsem);
> }
> 
> 1)Here is a trick to make register_shrinker() not use percpu semaphore,
>   i.e., not to wait RCU synchronization. This just makes register_shrinker()
>   faster. So, we introduce 2 semaphores instead of 1:
>   shrinker_rwsem to protect IDR and percpu_shrinker_rwsem.
> 
> 2)rcu_read_lock() -- to synchronize idr_find() with idr_alloc().
>   Not sure, we really need this. It's possible, lockless idr_find()
>   is OK in parallel with allocation of new ID. Parallel removing
>   is not possible because of percpu rwsem.
> 
> 3)Places, which are performance critical to unregister_shrinker() speed
>   (e.g., like deactivate_locked_super(), as we want umount() to be fast),
>   may just call it delayed from work:
> 
> diff --git a/fs/super.c b/fs/super.c
> index 13647d4fd262..b4a98cb00166 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -324,19 +324,7 @@ void deactivate_locked_super(struct super_block *s)
>  	struct file_system_type *fs = s->s_type;
>  	if (atomic_dec_and_test(&s->s_active)) {
>  		cleancache_invalidate_fs(s);
> -		unregister_shrinker(&s->s_shrink);
> -		fs->kill_sb(s);
> -
> -		/*
> -		 * Since list_lru_destroy() may sleep, we cannot call it from
> -		 * put_super(), where we hold the sb_lock. Therefore we destroy
> -		 * the lru lists right now.
> -		 */
> -		list_lru_destroy(&s->s_dentry_lru);
> -		list_lru_destroy(&s->s_inode_lru);
> -
> -		put_filesystem(fs);
> -		put_super(s);
> +		schedule_delayed_deactivate_super(s)
>  	} else {
>  		up_write(&s->s_umount);
>  	}

s/shrinker_rwsem/shrinker_mutex/
