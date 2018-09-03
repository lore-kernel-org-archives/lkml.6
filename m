Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE5C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E99F20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HLK605W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E99F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeICSCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:02:12 -0400
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:3232
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbeICSCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0uZejBT1vG26w9EAbghLF06Z6ZzRdQbrNd6d5EiDQQ=;
 b=HLK605W2DLB1OnUKM1WLwb8647w0WLChwc9k9M73EaFeRAoVtYkdNssa2YeP20kay2x4xrgBeLDrWJJkMSsQnlMcbhSVLPS/4jsJkfv3qABxHMHjMsq5rbM745nnJzVKsWNx6ukHyRdu7z9i4U97S7oPDkiQAOAnrPTWVhOTlAc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 3 Sep 2018 13:41:48 +0000
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com, nicolas.dichtel@6wind.com
References: <20180828231859.29758-1-christian@brauner.io>
 <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
 <20180829181303.4sacopk7y3p5xyou@gmail.com>
 <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
 <20180830144544.tpross4jd6awou4u@gmail.com>
 <20180901013427.tj3t2mlik4t7hlt5@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2319a029-7aca-b7aa-2e8f-4dfdeedcb6df@virtuozzo.com>
Date:   Mon, 3 Sep 2018 16:41:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180901013427.tj3t2mlik4t7hlt5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:803:64::18) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73133381-1681-406d-4b85-08d611a30089
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:mtj2WXz9UPSc5ZBqWAGzHOUP0/04/5PFQ+38j+qtSZT1hjNhUUFlGAK7AkyxnVZb4eykVe8KJYQ6z6PRlmZHsiZ6KMT714smVg5QxJaySgocT+CNHraYJzm76xG5QTUBdoXVLcsvTwkf07vwQfEofyVCZ2p3LqTJmGmxLZfM5WZNUDthh3elGGWYrSeYNbHM0MfYM/VvVkDSDO25NZQwq9CDAK8OmiNYqfbp8QMxnGVkAIOw2EtmVBoBJ2SCRUO8;25:Vk+T3l83Y5HPEc7fBQhrEOK12I44SzJvMJqAVYwJc2KHZyvGfuDZTzn+LkFgRMNGjzUlsocRYnLM8SlCsXosaOEV8KiqY5FHhhG6I8MObFBSOJ2H48RV7+WSxyJbcC5nbvN4yo+DcqQkXVUuMAatugrFXoOAaiIn9gnl0w6Q6o6YMj86Fvykq+SSdyBAC+7jgZXeYyPSHS4sbyCkDUb6YECJWSgBkJt3U2N+Ou7IU6Ty3+Urk5OTC8v1X5Zix1lishwgTA7Zz+/Z1QInIAJlAujo1jwb0Pov7QaZohNZOKfoQwf34Lx8cqmMKUdB4z6q4NDkYq02fo+12Zl4DAPJeQ==;31:CPSeejJYyYhqw3kEStg3zKVgWJn7v6kO5/O8DDy9ki1X4nqhqw6P2gbXI5fwYGQjlhR3HbpFFuNWhd+G8BJGt7hL6N1V/UIGGRhwDrWfxxBwKdgXQDVtHuC2dAeXYY/FBrKyil1qw1Dax6PYM0K7EUa4o++uyXExU0qhOLDef0gbd2Ytt61N5lbRDJM8raDtphwdlEFTZKpSUAWN/CkAZR9QUgNOOrMEzfrv6xoMUMI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:aPvCqohANGWRWn3fKfOraVYPjMMmmzWHhZZ4geFwho2rWMS8FuOlOpA2QzW1as5ovuPwxWn5iqltBwv1r+K4wGRjS6KCRNUkXHk2L3n+sjfs7sgeq68mBuvGvA7cn1l6S1qEGAYT/MiQjpFxRYzHadQzxbnzw+0m+x0SNPFWc405mWUSa4c/oEksF7JeKBPrAsuSs9VkogstGUXIyUXPOdE1YG9GzGWD8ul1ls723FBfN89SvcmzLWmbGIwsephzy7h4aqceRniE6Y6mzuu1NF7i99+2DkD63r4Xuc1lgVI/ohCGBKulljYph3vo5zhCqDY4Io70ibDXX4llG6AQQtds+entEnAxnVdO8OKuvbiaJ7T8E8jIpkEh2fVs4NmfT/a1bKx18tTZ0VGgNFUEtg8gGnjnBNr8tQS7hr5keEgrvuQyPGyZ7k4p3f2lMkDjNNcjUi7asOlsRRCWZij7rP2RLG8cjkeMx7pEnIahV3EvUEJ2pWbr+vaxLk4FP2aZ;4:Nhz4/g/S8F/q2OgKUzqqhXd9JdK2nMHwU+b3lByQRMQs+hF2Tlo1ueOo1xAsM+mKWyw1dZtqWAa9QCIZZseIxqweuXspIy5GAkELnySj3ZY4SH34e6/ogdbxn9vi1ShS/L1V+ZMambChA9swZepXjbtWKlY4vcdDh7dVxt8nKBCklsxRDPs/9l51FbP//E9DvMLAoEIeXRb6J4U8CPaMPZ4QJ9OrefPOyak+Yb4aMX4OGP7ThWrsGt//CwC74v65MxKHH6wZdJyXnylCeSSZUg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2026BA4BE6AA00EF6D25C466CD0C0@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 0784C803FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(366004)(346002)(39840400004)(396003)(376002)(51914003)(189003)(199004)(6246003)(6916009)(68736007)(58126008)(2906002)(81156014)(81166006)(6666003)(16576012)(8676002)(316002)(8936002)(25786009)(53936002)(52146003)(64126003)(5660300001)(6486002)(478600001)(186003)(65826007)(52116002)(386003)(23676004)(2486003)(53546011)(105586002)(16526019)(229853002)(4326008)(76176011)(14444005)(106356001)(77096007)(39060400002)(97736004)(26005)(65956001)(65806001)(66066001)(36756003)(47776003)(6116002)(486006)(3846002)(11346002)(446003)(31696002)(230700001)(7736002)(50466002)(7416002)(31686004)(93886005)(476003)(2616005)(305945005)(86362001)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6bktFT0NLamRYVVdLejR6aTYza3p5cXlk?=
 =?utf-8?B?Q3pOc2tWOVlLOFIwM2pjQkJuZGZQZXdVVEdDRWNJZ3VzcS9CZUN0REkrVzJ3?=
 =?utf-8?B?RXJuOVl5RnNldTdXVlFNQUNBSjJiai9DVGhxK2I0S0gyU2Jrb1gzaUx4TW5E?=
 =?utf-8?B?OUk3Rmh5cjNWby95eTZMU29uSFVtdEU4N0t3ZHFQNVJRdHFLTzZFWFpLQjZN?=
 =?utf-8?B?ak1VZ3BOTkhUQkh2ZlBCTlVoVm10SlZIU3NLNDV0VEZyL2Z4cy9LRHZsY2NI?=
 =?utf-8?B?TjJUeXBUTXZJNTBmWXoxSGx2QXZobUFlNFhLZzVhZDJhcmlxMCtCN1Y1V016?=
 =?utf-8?B?UGtsWXczZUY3TWZmZjJ6OHhwSFRnNnNjQnFkQmJqOFVVU1dkK1c0NUV6ZTlm?=
 =?utf-8?B?RENVdktnSStUYmk5Nm1QUVFPNTRjMXRta1Bya0dTdVR2Uk9jNUp3ZWFCUndZ?=
 =?utf-8?B?U1lPeUhjaDIrMkJlbVZQbmJqYUdEYTFHcmtnMHAwK0lXL25qWXg1Q3J5VG1j?=
 =?utf-8?B?NDNBYzhyd1VXdXloYVZ0dmZmUXVVMEhZbTVNL1VPR3FPTWF0MXZJL2ZsbU00?=
 =?utf-8?B?YTdON1Q4ck5KeWNmejdOT2Vlb2hGOWJob2dHM1Mxd0xTdkc4ZEVEWHdyaFFr?=
 =?utf-8?B?YnRUNFFKUU9ZMkFvZ1lxK0szNVVOZzRwRHlnNWNadUcwSFIxQTRsME1HS28v?=
 =?utf-8?B?UEVUcFZvejVROWp6MElMUGJUZzRPK1NUc2dXOU91Nm9PNTUvbjlBL2VnMFhh?=
 =?utf-8?B?My9TOVAzS1BNbng5VE1kMFB6Z25OQ0JBUjVVRUJIMHFQNzdkODdkUjM5ZHRa?=
 =?utf-8?B?R20rNnArZXRUbnZuSzNERHJ6akZZQVRMVkV5ZU9rTlVRRTQ1R1Y2UjRzUDJt?=
 =?utf-8?B?cU5DVmFQSzk5dTg4T0xBQWwwQlJTOFZwa0tyaGp6RWZwZkptajlKOEVpd3Zy?=
 =?utf-8?B?a3ZmRUhIUDlZRnJobjFKMmo3U1Y0S1E0ODN1NXJIM1BjTE1TZGovT2dHY2R3?=
 =?utf-8?B?WkVTNmU5bUk4eGlNTzVsM0NVSlZleUdJdGZxLzNCVHY2K0drSXJ2bTQ4ZUdn?=
 =?utf-8?B?b1B2S0ZYeFhEK3ptcjJOTEdwODNVelJ3K3VrYUkwYnhWeHNlWXQ3NVYvWDZx?=
 =?utf-8?B?WDBZTnFtL1RqMnhyV3FMVHMzekFGazRLeXhhUXZoOXVOMHdoWHdiNTJLRW5Y?=
 =?utf-8?B?NU9XV2RtTnVnWFIzQ0syY010alRtSUpaeHE5c0tQeFgzbmxrd0tnaXFxc1p0?=
 =?utf-8?B?MlBQZGlJRnNhMEpsdEd3OTEzSzlmdmFrSXBjUTkzbkVKcTM5VEFIeWk5MXUy?=
 =?utf-8?B?Vmw4a2daMkRmbDRWQkV1cldlcGs4UVNCWDNvRi84THp2V0VsMlBZbkJxSTdX?=
 =?utf-8?B?V1ZpU2M1a3VPSGsrWkd4ajNGL1ZMRTNoT1FVTVhCVlZUQnhXMm5uTVQvbTRY?=
 =?utf-8?B?dUVkSEVHb1JZeEJHdUxhNzcrQ0VhdSs2QUtHRmxiZXEvU2xGSGc5SG1DcG13?=
 =?utf-8?B?ZVdhbEFxNkdxTUd3UzFXcG54ZGl2Nm0xOURHeWNYekN1R1JxZkpjM2E3NXdG?=
 =?utf-8?B?UlJYYjhQUzFZdzhVaGpTYThCSE4zUktFZFJOSXlzM1RrUnIyS1M3SVc4OFJD?=
 =?utf-8?B?S3Z3WURmN2Z6ajMxTURlWnVJbW9aZkZlUkNiVVBadjFwVE1NKy95a2JzdStT?=
 =?utf-8?B?T3QrcThCSkRQUnFwM010MUUxSFU5S2h1c2Ivc21RYWlGeW1waGp2elhodWtq?=
 =?utf-8?B?UzFvKzV6dFlVZFljSTdGZk5rdTYrT2pQU0V0TisrMmVuWWlMblg0QlJSSDR5?=
 =?utf-8?B?aDZzaEw5WDhQZG43TVhqQWpOVE5qUlhuUU1abmh1VHdnakt3cnZsTzNoV0JI?=
 =?utf-8?B?UkxPSExjWUZ6SDhNWlg3NGIvTXArcVdNbFZEZnU2UFZucHVIKzVpNFpRQ0Jl?=
 =?utf-8?B?b3RwcFBXTWU4c3dOayt2MzdKYlE2aUptbUpidWczNEEvSE9XRTNyU2ZVckU1?=
 =?utf-8?B?SzlMbUlsUWMrdlFGZStZVWNOV0dPaWpIQUpHQUI0eGY3WVIvRWxQUm9YTzVF?=
 =?utf-8?Q?DeZ8L8=3D?=
X-Microsoft-Antispam-Message-Info: yB5nFBlekleAli+Fv8cWjNQqvAGEbik8qXcQto8QgG5fuhZZuQCwvDs0D+z6jpl51TEwS6oMGLwre2TCiI+PvNZnctqhX5anrHyvESl13SGlIEgT2/WkCZP9kiYiJKdk2NLDMR+XbPXnD668JotwkTm6EeIqh5GTRqUwEjs4oZaANWMq6jFaXcwF5CWYU0b9DUVcDb8dTRALvYb9/HPxyIfkTz+TFPCVvogHG4uje6pOumeZeK6GqS3SzKCU7W1KK/cXCRpnmJhoZnVu/t7svB+3ldkGRfJqY+pjukxOfkZ6fw9Z/vUsnf+x9xxey0KtPbqJrDlLKueltbAQQYxEGFgB6SBUBIM4Hg4k6FyEyrs=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:QjdHaIEgMF12r6EsXJQ3zgwBiSUHR28Iakxs7iPGwzjge7+jNJUUZgUkwTW9nHQTnzGjBBSujHNX0QLiPL6yj6eUB27ELVs/BIbrXHe7FHfCyvg1z/W7JLkC/IUEsu9bNwCC6GSKIVg4VAgiAtC+EvMWYAdy+5pXaDSRToVPWTgR7yeJI+g4LFcB+0DF7Fkjvvl8mcgOz3nQ+nX7XLDdztHQlUNzBfExPZjQWFsGlr9rg3rrIvK6fKtmuNaOlg5y35VqeJq3bxZclzz/+n3Fg/bq1eG9TeDFeL90zbBBO6hEv7Uwdd/qturc/D9UGyc6dtv8ZBuedeyKzO/oqgXrLub6Uft4VufywPcCqOznC3wY8LFwxfypVm7IQ4rJ4mR0mMpU9y3dZIxaoa1Mr/aQz1fKrdpez6NmZisHSSpZc9qEprPm+wgBdZhWRxUiIEIv5Ucqt5lgIiCLO9iRbTqgyA==;5:JQS5nTk8r76+Jyz3ilZTrkfM9JHDus93bvQTd2oaCjVSbq85v0sDMXvPHOKTQhsx8QX7r3V7LeM4DX7p5lheZ4nX5fLEASmzgn6L4Vbr/XfyOOLP0SysfGdonHuJyG5NQhJda5BrSqcyu6w1ag+LEFkBAFBBaNXT1vSb91Ashfs=;7:xlYM87xQuyIC8TCpeKl3mBm17wbMnkVlPLtfsTcLkGPcokF/FjyaCEohRsNPEAsL55H5dNN7miUa30mn1ldRz6hFThD1eOfRWG5N/Snp6Uy51pEXczTQe5g2WTzpBdAsgy4UDFVoEOsOU8tzZARxX7425pO9cmYSvXqn8DXSww2madZA8+4sXNWTR1TpFpxswSA+IT1R71i+4zkv2iyGRBd3X2ZvdMfkCr8hQSsAuOTWhj0gN/ti7dc8E+K5KWZh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:06zJcHCgWhzrY2JCmBI1YjCN6r5ciR6x7m027ieHnQVRF7DK5xpZAcQ6JSa7iKKLozsQ4S2tTLMuJb3Za98dYicgdHGSVUdZT8XGdzZC6IBJbNquCjhMiHp5pBAiTNcp8cBcc1Z8TAhQSE9Z/gl4lkHP8NPPqqrh9wPrh3apDC8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 13:41:48.8967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73133381-1681-406d-4b85-08d611a30089
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2018 04:34, Christian Brauner wrote:
> On Thu, Aug 30, 2018 at 04:45:45PM +0200, Christian Brauner wrote:
>> On Thu, Aug 30, 2018 at 11:49:31AM +0300, Kirill Tkhai wrote:
>>> On 29.08.2018 21:13, Christian Brauner wrote:
>>>> Hi Kirill,
>>>>
>>>> Thanks for the question!
>>>>
>>>> On Wed, Aug 29, 2018 at 11:30:37AM +0300, Kirill Tkhai wrote:
>>>>> Hi, Christian,
>>>>>
>>>>> On 29.08.2018 02:18, Christian Brauner wrote:
>>>>>> From: Christian Brauner <christian@brauner.io>
>>>>>>
>>>>>> Hey,
>>>>>>
>>>>>> A while back we introduced and enabled IFLA_IF_NETNSID in
>>>>>> RTM_{DEL,GET,NEW}LINK requests (cf. [1], [2], [3], [4], [5]). This has led
>>>>>> to signficant performance increases since it allows userspace to avoid
>>>>>> taking the hit of a setns(netns_fd, CLONE_NEWNET), then getting the
>>>>>> interfaces from the netns associated with the netns_fd. Especially when a
>>>>>> lot of network namespaces are in use, using setns() becomes increasingly
>>>>>> problematic when performance matters.
>>>>>
>>>>> could you please give a real example, when setns()+socket(AF_NETLINK) cause
>>>>> problems with the performance? You should do this only once on application
>>>>> startup, and then you have created netlink sockets in any net namespaces you
>>>>> need. What is the problem here?
>>>>
>>>> So we have a daemon (LXD) that is often running thousands of containers.
>>>> When users issue a lxc list request against the daemon it returns a list
>>>> of all containers including all of the interfaces and addresses for each
>>>> container. To retrieve those addresses we currently rely on setns() +
>>>> getifaddrs() for each of those containers. That has horrible
>>>> performance.
>>>
>>> Could you please provide some numbers showing that setns()
>>> introduces signify performance decrease in the application?
>>
>> Sure, might take a few days++ though since I'm traveling.
> 
> Hey Kirill,
> 
> As promised here's some code [1] that compares performance. I basically
> did a setns() to the network namespace and called getifaddrs() and
> compared this to the scenario where I use the newly introduced property.
> I did this 1 million times and calculated the mean getifaddrs()
> retrieval time based on that.
> My patch cuts the time in half.
> 
> brauner@wittgenstein:~/netns_getifaddrs$ ./getifaddrs_perf 0 1178
> Mean time in microseconds (netnsid): 81
> Mean time in microseconds (setns): 162
> 
> Christian
> 
> I'm only appending the main file since the netsns_getifaddrs() code I
> used is pretty long:
> 
> [1]:
> 
> #define _GNU_SOURCE
> #define __STDC_FORMAT_MACROS
> #include <fcntl.h>
> #include <inttypes.h>
> #include <linux/types.h>
> #include <sched.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <unistd.h>
> 
> #include "netns_getifaddrs.h"
> #include "print_getifaddrs.h"
> 
> #define ITERATIONS 1000000
> #define SEC_TO_MICROSEC(x) (1000000 * (x))
> 
> int main(int argc, char *argv[])
> {
> 	int i, ret;
> 	__s32 netns_id;
> 	pid_t netns_pid;
> 	char path[1024];
> 	intmax_t times[ITERATIONS];
> 	struct timeval t1, t2;
> 	intmax_t time_in_mcs;
> 	int fret = EXIT_FAILURE;
> 	intmax_t sum = 0;
> 	int host_netns_fd = -1, netns_fd = -1;
> 
> 	struct ifaddrs *ifaddrs = NULL;
> 
> 	if (argc != 3)
> 		goto on_error;
> 
> 	netns_id = atoi(argv[1]);
> 	netns_pid = atoi(argv[2]);
> 	printf("%d\n", netns_id);
> 	printf("%d\n", netns_pid);
> 
> 	for (i = 0; i < ITERATIONS; i++) {
> 		ret = gettimeofday(&t1, NULL);
> 		if (ret < 0)
> 			goto on_error;
> 
> 		ret = netns_getifaddrs(&ifaddrs, netns_id);
> 		freeifaddrs(ifaddrs);
> 		if (ret < 0)
> 			goto on_error;
> 
> 		ret = gettimeofday(&t2, NULL);
> 		if (ret < 0)
> 			goto on_error;
> 
> 		time_in_mcs = (SEC_TO_MICROSEC(t2.tv_sec) + t2.tv_usec) -
> 			      (SEC_TO_MICROSEC(t1.tv_sec) + t1.tv_usec);
> 		times[i] = time_in_mcs;
> 	}
> 
> 	for (i = 0; i < ITERATIONS; i++)
> 		sum += times[i];
> 
> 	printf("Mean time in microseconds (netnsid): %ju\n",
> 	       sum / ITERATIONS);
> 
> 	ret = snprintf(path, sizeof(path), "/proc/%d/ns/net", netns_pid);
> 	if (ret < 0 || (size_t)ret >= sizeof(path))
> 		goto on_error;
> 
> 	netns_fd = open(path, O_RDONLY | O_CLOEXEC);
> 	if (netns_fd < 0)
> 		goto on_error;
> 
> 	host_netns_fd = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
> 	if (host_netns_fd < 0)
> 		goto on_error;
> 
> 	memset(times, 0, sizeof(times));
> 	for (i = 0; i < ITERATIONS; i++) {
> 		ret = gettimeofday(&t1, NULL);
> 		if (ret < 0)
> 			goto on_error;
> 
> 		ret = setns(netns_fd, CLONE_NEWNET);
> 		if (ret < 0)
> 			goto on_error;
> 
> 		ret = getifaddrs(&ifaddrs);
> 		freeifaddrs(ifaddrs);
> 		if (ret < 0)
> 			goto on_error;
> 
> 		ret = gettimeofday(&t2, NULL);
> 		if (ret < 0)
> 			goto on_error;
> 
> 		ret = setns(host_netns_fd, CLONE_NEWNET);
> 		if (ret < 0)
> 			goto on_error;
> 
> 		time_in_mcs = (SEC_TO_MICROSEC(t2.tv_sec) + t2.tv_usec) -
> 			      (SEC_TO_MICROSEC(t1.tv_sec) + t1.tv_usec);
> 		times[i] = time_in_mcs;
> 	}
> 
> 	for (i = 0; i < ITERATIONS; i++)
> 		sum += times[i];
> 
> 	printf("Mean time in microseconds (setns): %ju\n",
> 	       sum / ITERATIONS);
> 
> 	fret = EXIT_SUCCESS;
> 
> on_error:
> 	if (netns_fd >= 0)
> 		close(netns_fd);
> 
> 	if (host_netns_fd >= 0)
> 		close(host_netns_fd);
> 
> 	exit(fret);
> }

But this is a synthetic test, while I asked about real workflow.
Is this real problem for lxd, and there is observed performance
decrease?

I see, there are already nsid use in existing code, but I have to say,
that adding new types of variables as a system call arguments make it
less modular. When you request RTM_GETADDR for a specific nsid, this
obligates the kernel to make everything unchangable during the call,
doesn't it?

We may look at existing code as example, what problems this may cause.
Look at do_setlink(). There are many different types of variables,
and all of them should be dereferenced atomically. So, all the function
is executed under global rtnl. And this causes delays in another config
places, which are sensitive to rtnl. So, adding more dimensions to RTM_GETADDR
may turn it in the same overloaded function as do_setlink() is. And one
day, when we reach the state, when we must rework all of this, we won't
be able to do this. I'm not sure, now is not too late.

I just say about this, because it's possible we should consider another
approach in rtnl communication in general, and stop to overload it.

Kirill

