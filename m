Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 62B7FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAEE208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ghVD+uZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAEE208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755248AbeFNLtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:49:05 -0400
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com ([104.47.32.43]:15384
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755173AbeFNLtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZlLfr0MhIuLqosZAL2xmyESLauMHdjDNY8EpnwL0pM=;
 b=ghVD+uZChBKkIJq2nO4xONifZ3XwP83EQmyWxuj1UA07wc6s9Z94t33wnFqMOIPS/Bmec0zG8LZN4y0WI7Ok348jQuzw+JPwZWZDzR692kEU0dKsU2J6OY3se3KBqNw1w245afHc/lDJbep9sS0h9qgtP5pmp1Jpijrqf3OCEHA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 BYAPR05MB4584.namprd05.prod.outlook.com (2603:10b6:a02:f2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Thu, 14 Jun 2018 11:48:51 +0000
Subject: Re: [PATCH 1/2] locking: Implement an algorithm choice for Wound-Wait
 mutexes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180613074745.14750-1-thellstrom@vmware.com>
 <20180613074745.14750-2-thellstrom@vmware.com>
 <20180613095012.GW12198@hirez.programming.kicks-ass.net>
 <69f3dee9-4782-bc90-3ee2-813ac6835c4a@vmware.com>
 <20180613131000.GX12198@hirez.programming.kicks-ass.net>
 <9afd482d-7082-fa17-5e34-179a652376e5@vmware.com>
 <20180614105151.GY12198@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <dd0c5e50-ac14-912c-d31c-c2341fdd2864@vmware.com>
Date:   Thu, 14 Jun 2018 13:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614105151.GY12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To BYAPR05MB4584.namprd05.prod.outlook.com
 (2603:10b6:a02:f2::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88deb68a-f822-4f15-3acd-08d5d1eccf3c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4584;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4584;3:GHUl+n28T+JTKw6vPQ59PdnsHyNkoS+CJMVPbVdWNtFKJr0p+TBbkl/k9DQC4LIxXFCL8MYguTvuypAE110qBvVCpzypPxy2aywxdSYpAhvpEtzMjjNw6CzYlCYMaRS+lKLqAte3OOh3g0ozyYq8PmFHogtvJ1B9LEtUbJbzRW9KhZF00HHkFrQ6KarEy63BsxKjn86NpaGYIHN/08HblrD/LEr/RZfK71V4aXKkMM5gLPo2bP6V24D1RzbXiyWm;25:KpDQxZBPsurTAELCjtIOE9WrxnR+fc/iAN7N62iEKTm35gxlE+b9bN4XmW58HFggNb1fKIK85g1qnnP3wGNDTtdhRTJHYy+OTc0gyPZzHZTF9xYuWmobf/xU9+4t/lLEq5vB6wJ670V1o5C+loLs8tisz5cxSQQEZzGOf/NKFfqLpV7vjCfxdgHZ8ROKILy0tNbKfJ5TYX28tnez2wPDR9ewl9AKTieZHLthEuUp9+momWz2u6UrGM888VwxK328b3Yht/LnKxd6cxIIvfORjaCWEglKB5fG+E3Wg/jejDEiSBdEKUaSE5fMXbUMjX6OXJBHPj+vgnYF/PBbMKiiyw==;31:r9HMQCvg0L4127/BkU+16I3jJwe2EDcW7vEdSqFNQ/OQ4GB9lMrA7sYArWLTGcY/4dpGmLz9JRBAi1CfHqsgXDiYq14XNMcGdBZdlE0lgrjCVD5k8B7nTZOZY9AIbGNGrHk+ulvTk+XP7tCOVDK+LriVy7DsaL7rsshcUB+IC80AOr5nuyZBJuxm0mQl8QAWGLvEZFBrl0DVOvDmyag4+6+RxFLVDLsTiQ+vYdvMOCQ=
X-MS-TrafficTypeDiagnostic: BYAPR05MB4584:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4584;20:Ed/0JZksyLl8ZCwTJMOAxDQ59ippWkUlGVcK7gyn78PcmnFPynQyQNWP4q3a5B6LHRzQBoR3SBwDduNJZOvxeeB3cypnVuqpNdJ0dV5zQ1EwOLzyPz8UiqJRKvare0uFuFQMQqHpbq+ASJgJbVK5aCvPBmwM0dFhRZEGml6mKnel5NnUo8z/ENX5BesXJFqOskIzSBTTx9ykP1Ip7mmsXCpBt3wf+N+8rCxrYU2eC0eFSMwvlAnOiYHr/EYzL5zhJ8k7gPBr3aoPfMGNk9hBoBUxkbR5TbXbR41WdEJylaAh2AquxsDIP0ovImkG+xeq1A38t+CUqujmD62IvZEsrVezNBG8+EUb+h2iivBpHM7ggToKnYDREj+5n+UT0vb82HsNDjQ3nJ6HHGOSi8bCQr9TlFmyEhHRgz+FAGdfrFpuQsQ6g3pP0XLWE7UFzL496xfYZJ1lr3L5Ln17gb53HsCMFL+xL1n6vRqp+CadrZDPGNWcdpSUfrp+dZ16699G;4:D2SXEVEbaaziHlgHSD7UXqfY9dmt5StIbw+VmgVVDLKNBLOeiFnKq7IuXiJ1OKAGg/HtVykD4XP8KiBZMTSk8WpGxkrRft/1WRc8ZCmmTuD6aTAxh/e6OF2cVXcWYVTj8c4hCNgnRHr4P3dtqyWDo1wj1jfX4iKQH5OnJU74VwNK2pmzdu2LWKJYOV/vG0W5p7vtt/J8wehNdFQUe3fQP16u+Dfs2ELPgv4htwgwGO30nEetH4kEsrfj8oxWz3blFL4zGZ/XnFGSBYx6mVAB1Q==
X-Microsoft-Antispam-PRVS: <BYAPR05MB4584917A0C4703E6C79F9383A17D0@BYAPR05MB4584.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4584;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4584;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(346002)(366004)(39860400002)(39380400002)(199004)(189003)(186003)(65806001)(66066001)(6246003)(551934003)(64126003)(58126008)(54906003)(6666003)(6512007)(4326008)(229853002)(31686004)(53936002)(478600001)(97736004)(6486002)(68736007)(106356001)(105586002)(25786009)(8676002)(52116002)(23676004)(2486003)(16526019)(52146003)(81156014)(81166006)(5660300001)(7736002)(47776003)(67846002)(65956001)(6916009)(8936002)(65826007)(76176011)(305945005)(7416002)(446003)(50466002)(956004)(476003)(486006)(59450400001)(386003)(6506007)(36756003)(93886005)(316002)(86362001)(2870700001)(53546011)(2616005)(31696002)(26005)(11346002)(2906002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4584;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjA1TUI0NTg0OzIzOkpUcytrNFFFUm5ETnNRRW53aHBwYTBNZ0p2?=
 =?utf-8?B?NnFyVkx1SGFnZEVIMExKc3JhYmxVSVJkZWcxazNrenJqMUJicG5oLzZlbGZO?=
 =?utf-8?B?YzdseHQ2U1BZRFVJTlVOK05rYjZ1RURkaWZjbW0ya3RXTkR2bS9ETGFlb3VE?=
 =?utf-8?B?cC9kMFc2d0hCSVVEbVNrb0VEOFB4cXpDU3ZmTU9mNk15Z0U2Q29qeDBZL3dr?=
 =?utf-8?B?MFJwcTlwcnBweEdBRjU4M2VIZmRvNk1jM2F3UUFzS3NVSlJJYzQ1Yitpc1gr?=
 =?utf-8?B?dTFPTno4dzNvNEcrUng5VU5qS2FZRHh1aXl6a0xVb096S1pXNklhZ1BRL3Zw?=
 =?utf-8?B?VEFhdXhHVUhwVWlCK1hrMkl2NUhTTExUZmJFV0UxZlh2dXVZT1dzWHErWVN5?=
 =?utf-8?B?bWhWdkt5NEIrVWRsUkZpVWRMcDhoZXZSRGpPTEY0b3dRNHlzU0xXVVptZ1dJ?=
 =?utf-8?B?N0h1cGEwZ1JoR2E4SFZxd05RbTd1Z285SE8zcWtsdXprTFFnNVVmWTlUcXhq?=
 =?utf-8?B?ZVlFS2lONXl2NkJrdlQ3cUg4UWtITTgwcnhvdDNPQ2VvdFF0ZFBGNVFKTHRI?=
 =?utf-8?B?dldCR3BYUWFZSDNQTENleEZyZDJWU1BTcXF5NVdFL0VrbHZnV2dvWjJoTm1S?=
 =?utf-8?B?bzFNalNzQVNBSXNiNHBFYm5KanFZUU5pTTlJdW1UZEtNWEVoc1JRczRSdENt?=
 =?utf-8?B?Zi9XUXgrSlRVclVEOVVQM0t6ckZPa09OVHdSeG9Zc0xLT0JkbTBRc3FsYktQ?=
 =?utf-8?B?VzRJdDM2WUlTVTYxRG1uMjlCOXIyRzBXN2IveFFaRlVjWlJEZWY5dEh3QVFH?=
 =?utf-8?B?T3V4enlXS1QwcjFzMERjN04rSGNZTGluaE0zWmpqaDhleDA0YlRXVHQzcU1m?=
 =?utf-8?B?K2FUb0dDSkVyb2JiUzdwUTFXTkxHVkFqb3BhRjZhOXBEV2R0MEZ1aFp4UEE3?=
 =?utf-8?B?VVQ1ZTlNNUVCb3FjTm1teDdiY1RIdVNtVDhpa0ZoQldMcWNVRi9rQVFTU1lI?=
 =?utf-8?B?STd5bjlNcitESW5IMUVKQnlNd0NjK1lwMDliRlNOSTNRVk1wOE1CNzYzTWJN?=
 =?utf-8?B?YjVkVnJZVlNxaWdxV3JJMlVMSWM1TmNDeFhDRkJ2OStJRDJ3SWJEODV5Unc2?=
 =?utf-8?B?U2pUSU15OXhvZ1p0enNOMW5SQXNSNEt3cUlWNnJzNmpOdzFwZWN2MmQvTzYv?=
 =?utf-8?B?allyNW9yRlZLbUZGYW4zSUc5YXAvOXJGRitXWXFFT3FtVktOeXlObEtZdnBk?=
 =?utf-8?B?OXBBQWYwOUYxSWNNMzE2a21lZkllcFRZSjJORWsyOVp4Q0dCbnMxTk9oNmVK?=
 =?utf-8?B?Umh6WjRQZW94U0lnRlpyZUs3RVJiU2l4V0dhNlVTTzlaRWF2WkFiZlVHeXdX?=
 =?utf-8?B?NWZub2Jnb3haSXpyRjVqNW9WdnJ3bkxRcTFQc0RPektNZ2JwNEZPaENCV29y?=
 =?utf-8?B?R3ZMVFd0Nzk5emMzeEdxVm9kbEpoUTVEcGZqRzVaUFlZbDZWMVY1azVPMEtL?=
 =?utf-8?B?aWZ0VkhrSXVBVWZUWFlJcVlhYlBtYzVEbjM4UmV4bE8rOUZYYmxCQ3NYNGJr?=
 =?utf-8?B?aHNYenJXNk5Ycmh6NWlxdk1YUkIxaWxrRVA5RDhEZHdyYjVBai91Smxka1di?=
 =?utf-8?B?UzN3Qzh2UWUzekhkVWpLRU1pYThMeUF6VHlFWWJtMjdocDBxNEREaFduOFcz?=
 =?utf-8?B?UjJKUFAxVFNpNnFLZk5vYkhvMjRZOXFJTkhHWS9RcmNDL3RKS2dwWS8rRVRw?=
 =?utf-8?B?MGN5N285UGRicWRlTGljbUxIUjIrNlhDMWJtMElEMXNRWnRFb29Pajg3Nzk3?=
 =?utf-8?B?UzV5VEpHWk9LU1RPRDh3cE5UM1FPWjdLRlZnVkNjdXZaWnVJVmhlOE5pRFVt?=
 =?utf-8?B?UGdiVW1Ta1lPVDVqcnArdnZaSHFERktRWEhrQkx3ajdDMFJZOVZiYkYrNHl6?=
 =?utf-8?B?R3lxRnNpdzR5bWtyVmpXQVBpaUpvRk00Z1BQd1hhUkhLSXNPV1VPTFFxM0ZW?=
 =?utf-8?B?Z1BOaTh0VHBvM3BqZzhEWFFEM1k1Z0p1eEU2SmxkU1RGRm82cW1ZaCtPYVdC?=
 =?utf-8?B?dkNpeXRXajA3cUUycGNIZnQzSE9FTWpKRmxoZWkwc3o5emlTbExEMFY3d2dt?=
 =?utf-8?B?SUE9PQ==?=
X-Microsoft-Antispam-Message-Info: oLqWxLdjJxWdnKKBeQmNifoprZ+/LDCe6W4G/NkW4X56V7S12XKhqfpxNLz+7g8q/CbBgWQUXP2yM13y+vkgXBT579X7kD1RgQCYGZb+PNkk08WdccF3IQ/WJAQAuQIruLypIbTFWARZhJuWCg0NsaeX5JBzOrkMaX56MbGjqDBGQGWtQygS7jbd7Crh0GoW
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4584;6:VoBEcsPHNPkBzKInwIgldLFWVz5SwfJjAHK1MKepnMxh4r6D+qofJovtWmKXyjoh58HDAKDX3gBfviPUEC2JnMeuSBXGVniVJCPy74QXDRC4IJ2ZE21sdyxwfhDkC6SRhfqmqjH8BVInTjXiXB0RwXfnYLM89ff892lhAAdNwHU/gcliTzxqYca5/z07Mg7f0G4pYLAUU6+PbdTGC8kdziIGGVdreA7zFxg0kPyIpr1KI3t2X0zk/KNwItc3YIMmhocNMrgY4KS1pJFGCnqZYhhqQ8QUGr+66FfTlPK9ubCyt1iUv1JZaoygi9ePsUORruvtUEhgAl6MMd2w1+0VB7zbZJIIcrb8C8kK4h85n1DyCNEZDVN16YkRfV9vAV8SqsgVZq+2zCdzsn/vZ4qGFxlsxrkD1FhRrLhkKvN94RoX7oq9lReXq7VqUhaUgEpFOtLI2fI/bq5yI5pDF+RgcQ==;5:Snub7qG/3L7ulUly4JEYWgBhnVv6Y/gKyBdscQ7fGbt757fUsVWFuGEXsHvLEXQu//dNSvRMjicS3XZSQjJr78FSO7seIU8Y5zK+Cx85rnrLALU+Wrf9o2JS6Zl5oCVfBoQXgQbpOtFbrbJ8oewBDXMoHZG2oSvOlD5qVggw/DU=;24:BPtKNQtEjDTSTKdkkO3rGdJ4cnHXWi5u9dkgDPzW2vo0gd2ZI0ypOtpviaXmyGfPuWfmIVMZ/HJF4Iq29hJ315dV5yJg5PDmFtIedGQP0Ro=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4584;7:4jIosJHFl+TC7rVfD4pTxa+gVp6sJfR3n0QDENPQ4d5PM3BLXv8yj0PzqE07SJ+4vwAqiqddM4h2rNweD34rGxJf/swr6b8K0200QuHtLfjgpSIbtw3+UeoNquVnPl4mZYW603ejsRUfhwYVmyC/cy8dvN/ahR6xCWPx53JBKlOSevY7Sl/c32L1uAh48nj+CcPpNn6I5IwvnyZcG0dtlzWoUmTK3tQ1qCPzXsgvN3tCgaDMZJwC4VoAjKVFG1/V;20:YtTCddUHDxo54tmb4cmiOiwYJdeWhf0jMRdQosvQ0auUUM+3zbZlUkkc0TqkHzqMPHZSF+FPpHCH3Xvi9KeIo9HteSBQ/Yu/Mbcy/5xTCCTu1k6ZYD+/JywtjRyCtBnL17u9tsdv1Xs24SOOF6oWdj7F8xdBPJpGI6h4Ib3cCEg=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 11:48:51.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88deb68a-f822-4f15-3acd-08d5d1eccf3c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 12:51 PM, Peter Zijlstra wrote:
> On Wed, Jun 13, 2018 at 04:05:43PM +0200, Thomas Hellstrom wrote:
>> In short, with Wait-Die (before the patch) it's the process _taking_ the
>> contended lock that backs off if necessary. No preemption required. With
>> Wound-Wait, it's the process _holding_ the contended lock that gets wounded
>> (preempted), and it needs to back off at its own discretion but no later
>> than when it's going to sleep on another ww mutex. That point is where we
>> intercept the preemption request. We're preempting the transaction rather
>> than the process.
> This:
>
>    Wait-die:
>      The newer transactions are killed when:
>        It (= the newer transaction) makes a reqeust for a lock being held
>        by an older transactions
>
>    Wound-wait:
>      The newer transactions are killed when:
>        An older transaction makes a request for a lock being held by the
>        newer transactions
>
> Would make for an excellent comment somewhere. No talking about
> preemption, although I think I know what you mean with it, that is not
> how preemption is normally used.

Ok. I'll incorporate something along this line. Unfortunately that last 
statement is not fully true. It should read
"The newer transactions are wounded when:", not "killed" when.

The literature makes a distinction between "killed" and "wounded". In 
our context, "Killed" is when a transaction actually receives an 
-EDEADLK and needs to back off. "Wounded" is when someone (typically 
another transaction) requests a transaction to kill itself. A wound will 
often, but not always, lead to a kill. If the wounded transaction has 
finished its locking sequence, or has the opportunity to grab 
uncontended ww mutexes or steal contended (non-handoff) ww mutexes to 
finish its transaction it will do so and never kill itself.



>
> In scheduling speak preemption is when we pick a runnable (but !running)
> task to run instead of the current running task.  In this case however,
> our T2 is blocked on a lock acquisition (one owned by our T1) and T1 is
> the only runnable task. Only when T1's progress is inhibited by T2 (T1
> wants a lock held by T2) do we wound/wake T2.

Indeed. The preemption spoken about in the Wound-Wait litterature means 
that a transaction preempts another transaction when it wounds it. In 
distributed computing my understanding is that the preempted transaction 
is aborted instantly and restarted after a random delay. Of course, we 
have no means of mapping wounding to process preemption in the linux 
kernel, so that's why I referred to it as "lazy preemption". In process 
analogy "wounded" wound roughly correspond to (need_resched() == true), 
and returning -EDEADLK would correspond to voluntary preemption.



>
> In any case, I had a little look at the current ww_mutex code and ended
> up with the below patch that hopefully clarifies things a little.
>
> ---
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index f44f658ae629..a20c04619b2a 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -244,6 +244,10 @@ void __sched mutex_lock(struct mutex *lock)
>   EXPORT_SYMBOL(mutex_lock);
>   #endif
>   
> +/*
> + * Associate the ww_mutex @ww with the context @ww_ctx under which we acquired
> + * it.
> + */

IMO use of "acquire_context" or "context" is a little unfortunate when 
the literature uses "transaction",
but otherwise fine.


>   static __always_inline void
>   ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
>   {
> @@ -282,26 +286,36 @@ ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
>   	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class != ww->ww_class);
>   #endif
>   	ww_ctx->acquired++;
> +	lock->ctx = ctx;
>   }
>   
> +/*
> + * Determine if context @a is 'after' context @b. IOW, @a should be wounded in
> + * favour of @b.
> + */

So "wounded" should never really be used with Wait-Die
"Determine whether context @a represents a younger transaction than 
context @b"?

>   static inline bool __sched
>   __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
>   {
> -	return a->stamp - b->stamp <= LONG_MAX &&
> -	       (a->stamp != b->stamp || a > b);
> +
> +	return (signed long)(a->stamp - b->stamp) > 0;
>   }
>   
>   /*
> - * Wake up any waiters that may have to back off when the lock is held by the
> - * given context.
> + * We just acquired @lock under @ww_ctx, if there are later contexts waiting
> + * behind us on the wait-list, wake them up so they can wound themselves.

Actually for Wait-Die, Back off or "Die" is the correct terminology.

>    *
> - * Due to the invariants on the wait list, this can only affect the first
> - * waiter with a context.
> + * See __ww_mutex_add_waiter() for the list-order construction; basically the
> + * list is ordered by stamp smallest (oldest) first, so if there is a later
> + * (younger) stamp on the list behind us, wake it so it can wound itself.
> + *
> + * Because __ww_mutex_add_waiter() and __ww_mutex_check_stamp() wake any
> + * but the earliest context, this can only affect the first waiter (with a
> + * context).

The wait list invariants are stated in 
Documentation/locking/ww-mutex-design.txt.
Perhaps we could copy those into the code to make the comment more 
understandable:
"  We maintain the following invariants for the wait list:
   (1) Waiters with an acquire context are sorted by stamp order; waiters
       without an acquire context are interspersed in FIFO order.
   (2) For Wait-Die, among waiters with contexts, only the first one can 
have
       other locks acquired already (ctx->acquired > 0). Note that this 
waiter
       may come after other waiters without contexts in the list."

>    *
>    * The current task must not be on the wait list.
>    */
>   static void __sched
> -__ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
> +__ww_mutex_wakeup_for_wound(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)

Again, "wound" is unsuitable for Wait-Die. + numerous additional places.

Thanks,
Thomas




