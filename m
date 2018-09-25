Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915A1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA1020867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T4dKWCXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA1020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeIYPEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:04:39 -0400
Received: from mail-db5eur01hn0217.outbound.protection.outlook.com ([104.47.2.217]:9069
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726660AbeIYPEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqFwgsrL/2ERtaHZfSOnebpEG+bhCU91a4Zg4yjy4rM=;
 b=T4dKWCXMMlkmrqgmWCwLbjCoIEFm69pn4/1RSzMFaYQhOZ1lqpbToVqRjz2Ql2dTJXZj9E+JJFv1lUUE7U5xLGGvShBtVIJlklC4kLD7fAijlXASSia+/LPtXin/j1azMH+RXgga9audFL5CCBv+M049uz+QNwvnasBa2gs7yu8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 VI1PR08MB3599.eurprd08.prod.outlook.com (2603:10a6:803:85::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Tue, 25 Sep 2018 08:57:57 +0000
Date:   Tue, 25 Sep 2018 11:57:52 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 3/5] KVM: x86: hyperv: use get_vcpu_by_vpidx()
 in kvm_hv_flush_tlb()
Message-ID: <20180925085752.GA5391@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180822101832.31763-1-vkuznets@redhat.com>
 <20180822101832.31763-4-vkuznets@redhat.com>
 <8da03d2a-5405-f363-f081-e4bc46b106e3@redhat.com>
 <87r2hs7cco.fsf@vitty.brq.redhat.com>
 <87zhw62797.fsf@vitty.brq.redhat.com>
 <74055c3b-be66-4ce6-e727-a155f18a0ba1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74055c3b-be66-4ce6-e727-a155f18a0ba1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:7:16::28) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 182afaee-0059-4e13-d38b-08d622c4fd9e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3599;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;3:lOmcwOQ3b2MYFxKIAE8uIzu5EJ0wB3eXL2E1frWvRDuXqOcbB4jxRWGJlKJ/yXyBhCUGzDzxlbrDjUbhjToyFPzNvQpTPA+kBE68tVkKzjf5ZR+elRVO5GtRliSKX1rugiHVBI8+XaPRK2qGV1WsL7zg3u+VlACxiQcJN5rf48LYDPLKFSMgrlMIAx1kNwoy78X0Jqf0KhIEnZyaX8BiISWXi+bNFlNGYIteZjAeY08/RgNCyMNwL6HyjjPnPkME;25:j/T9WH4gO9S3iG2/rNdoF/K9XuxFlJTVLGOsAlHsvPXVgYsV40QIvWofcZit6tmFQsTwQhFNqujho49uAdZg3+b+LeEa60BoKXwkEiQrgM5mVQLK3U386/2uRCQeZosEKhyo4sHQRndLffSmkp7mKSZbmPc45DhVMrpjK52w9dqUFHNZfE9Am9xZejPAE7/37wS16SGPUwWECKKIGU0++wnVOvj4Osrfjzfo1O8H+ldDmUBHzTS+hI1dA7SnOGIEuZH6SeVI01GMdVfcPM0++H8Q6hmnVnqJPYtg3K2NCt/9qqjbFwwNbEggrB1bUJc/X2MfJ+X2vPFY2P3NaIcNbA==;31:ZU1z+Ozkefk8CA8sxbMAjLUCs1+An8pRS52y1rBb5M85dHjLuhfOJu8+HPj9IpvZlFLCA6Fsk90sK8bP4hYbxoPFlNdgpQlUOiWNryxz/REtQEiuq26fwjeXniliLG6zNRs/VMC59VDalHAn+VQtp8OmyzSKw8K/eXL8095rOA/bvTv4TwvuS2rLPNqzpCzxprl3kjtntPovJFBpGpsKISzVAThrr7CUs409CNWj1q0=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3599:|VI1PR08MB3599:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;20:cS/fsDmKiJ588BDqL7bwndYANLqWheq+4KT4mVxq+i8hlNXCXW8XmmcaUbPlOioMsm8HR0P47bM8uoHUJFO9tUc95yRMKAPV9hFtVGrcrXme2tBMtz/3sBW9rvEW8ajXfUd2cVi8Hrj9n9Q9BSjF9gv+8HVOLs6aN+9Ro4NVK8IozlhUkdabK0SNC9R6X47gPiGwoO49sKSQGeOAeJypQ7rxQBr3jq1CX/lYW32CXkC2FOsQGoftKmAAENh0qWXj1E1DVK2/vE9E+JaG5yBok65qla6kuPuvUhHvc9b4YTaksjP34lz6MZXg7bJGDDL5jlgYr/QqUI7+3PgJTP21apBmbprCZAmKDXvQbHp0ByXo38Gr7I+n/zn3WeIQKspbUi+U2D+D20xDk/71+ZDoWvuHiPIpEgP/uSm4wwTG9MJ8EF99YlET09RgQH/ejWIeTmZXH1ZtUhlx+gIzQ8AMAuMyXxZeiK59lHCRDGm5GV3TLkdW4RAV5M8TwfhTBpLh;4:Qsd1TzExE0m3+eiTreUSqEEfIFucrvkjcuJiZ7uPTGVKnGiQaz0TA7vDQkm1wKPU7Sro0K/yVOW7sl6xsBEhwa+d6na2IUrddyYeZ2pnF3WItsCT3yMuRVXL+IK7lSbOl5kiplEp/tn7BPqEwvM8sGvDuLFu1zpTEtxyGMTAtrrlWSqVN9vb43NrY3o6HpO5Q5ZZWYq5l95cqK/yZsJnQQaHUbkgNGfof5vDEI/Z40dXmIVCVx5qoFvIZiS3OlDIrKXeCY12e5+XPCuV8sChLA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3599AA3B84884127A4F2308EC9160@VI1PR08MB3599.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(149066)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR08MB3599;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3599;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(396003)(39850400004)(366004)(136003)(346002)(376002)(199004)(189003)(57704003)(69596002)(6916009)(8676002)(6666003)(486006)(11346002)(81156014)(446003)(478600001)(476003)(47776003)(956004)(7696005)(86362001)(52116002)(97736004)(8936002)(93886005)(6506007)(316002)(81166006)(76176011)(53546011)(2906002)(5660300001)(6246003)(53936002)(26005)(106356001)(16526019)(4326008)(39060400002)(25786009)(386003)(305945005)(7736002)(54906003)(7416002)(16586007)(1076002)(6116002)(58126008)(3846002)(36756003)(53416004)(229853002)(68736007)(50466002)(105586002)(186003)(33656002)(66066001)(9686003)(23726003)(55016002)(30126002)(18370500001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3599;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3599;23:4pjTGjibMWEcJlDsUK3a9bEVWh4g+WHTYz6daBpfE?=
 =?us-ascii?Q?b11RWQVla8XkJKRjttqctphFdOzZhmCNgGOgI5SyUQSs/cEB5abCoHXS48Yd?=
 =?us-ascii?Q?ccXK5cWkLg4T+QVJ2/3y2e/D8/fOyyyTwr7k6RMxcyf4UCFUYUhA+b/X4p4A?=
 =?us-ascii?Q?j7RteFulic7Y6xe5iEjeBKidCac0/cuxqrHRLQSJfolHGV2WkOWhKlzrFrch?=
 =?us-ascii?Q?BFFJ7/66TOH24pIJ3SAU9xlPzGec1M0hs74WKtIImQfQDlOOS42Ot6jG1b7v?=
 =?us-ascii?Q?SD7cBynwRvsNd1KuSR2dFYV9rwXE3lp3UrrO3lYKfsAt9Fixc6hnby3tesuZ?=
 =?us-ascii?Q?vB/YGz4vmWkOLnrXzZZWgh3gTFLCtHn5do5+wsDnr+PBQEn8ZI11S5a/DrTx?=
 =?us-ascii?Q?NnleSSJ7/08tL1Fnj4/sJgvnxZGQvhGtGtzkg9CJQy31LBxlLNkxHN/N0jrH?=
 =?us-ascii?Q?mqF9fO0RF44/lw6xjAVh276gxjJ8ORS8dyFormKmjnM7oHAjR7I5WfLftxua?=
 =?us-ascii?Q?t1RC4knUL9W5rmzeSuNlkru7+TzZeQBBqWx0U2oJ111bOOUGErKk3MlhUzRg?=
 =?us-ascii?Q?yTFCxjsZprOnNf+0y56p1Q/k0n6Yuf8F5ELgzLkYXN3bmUZl07NryU2529sm?=
 =?us-ascii?Q?di8aLFg8WHX6CCq2wik2irx4i9pYPvdjDXvpF5uLzq0SUdnHguRzYQLfzwHR?=
 =?us-ascii?Q?wfi8cB4w5af+Tod78OjJ6d6s1v1p0+Oz6ytWSmmCZ2DEy4eGLSYeDcoyIIwM?=
 =?us-ascii?Q?CVx7PeAZjpkExHC2X9+CZPPf4lI2RiIvTx3C9cWujGmb1zaN5xpoVwHENKCI?=
 =?us-ascii?Q?+2weDquOPgAjCCp1v8Juu1hTdV5blbmkII4h4bBEQ74SIPgdGCJj2Z6zoiCR?=
 =?us-ascii?Q?4cEE8hd0kIsf1Dil+MXUqC87iGFEs632EQB9zyg2/Cw1v9lplDfu7rwz2wV1?=
 =?us-ascii?Q?W/98vTp+xQ2oYy1J0opBojshVxnuRQszMjsP/7aPjrg2KOQ3GYiGLIRkDzU2?=
 =?us-ascii?Q?1XSoYbmMTcTlQOoCDJ5W7lr2rYBdSFyXKZaTpKLISjfGAhi5CVj+VQXnKkfu?=
 =?us-ascii?Q?YPCOzsyykc7S+jHS/hIbVgC64n9n1aBNEVESIJ/LK5wt5m6Y5hran6G0fwEl?=
 =?us-ascii?Q?dd2LXcdMmErRLmei1yj9YM/QsT1Ooi25iuQ+waRtf8o8RSuJovzu+qvxI/Ey?=
 =?us-ascii?Q?+L6NZQYiI2kA2rbFFSxU9jeLQgo/E1nZsk8VwwW+Bvbs3PDV+kee+TdRYsRY?=
 =?us-ascii?Q?gtAMrvdr7bjSvWO/rhMhBO+xNr/hNaQkfPa32Ao8dFOMKurunoYXfJH6aBGx?=
 =?us-ascii?Q?nNcjbpXfMUyEw8oEH/F6rl/TDpsRmhb/NQGxstE5mOLwFMZiQUci19PgZtPf?=
 =?us-ascii?Q?VginGNmTITvYsX0Kjjd7Ofn7lWCv1pyGfsjQirvBqxCKs4Y0QxAGrR3FXauC?=
 =?us-ascii?Q?pI5DyuV1rRtET489+ShKKAnlZWbaWS85a+pu5hZQqHadTvTokL7L+runQWR3?=
 =?us-ascii?Q?OHycJVWnABU6Q=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;23:aeWPuwQP4XxS81d+eVAya5vyt2j6eSRXcEnQabpT9BOqLJAmZxiaB2PvlJdW6t2qYLmc5taFjHzvLKHyit0BDov8Okj5kwniIfS/CrsNYcbrkxbEQ9w9uQa+1OBZ6Mr4PEFkYjmJAK+VC6Waa/ICHQ==;6:5dH7EmxsSRI6C0JP3FdUJf9bLuvl4tCiBG0ZdMx2e+He+EUTuTCVa9WyBEuqUBlKAg67vZzPvwbhYMm32oEth8V3bFmoUMnqqaRUj2MiDNzKyNYnIMOigEEdFR6fUCr3OHnBg1EyY81vrR50pMvVRGkfHH4IbDXzrTIAY5eqPM3yFxM/zMlXDhqGZgvbdYzn2jSjRUfBSrNsafaLYyIYGITdTg4QtRA+LRsQtglNrFv7TCwE08ATBt+yIsi5MOWU+lmRHD2ARGK+hqkVZjBtGlDfqgQLrrpubE7VqnvGDOIqbEatoKicmcISUH2LE1XySFVHvnFJmA5JO0AGXNKsrHqR2xZS0J3jJL4/PwUL2p8lZWIpoP7bh0bYsFag8P6J0RFU5k2IfyqiU79iWkzutMDoFocxtb5NuEGPyHiKLPY0CuCmhF8Npxv7/HeJOmzEB6mci/QW8Hn1Jwf2WDGDEQ==;5:y4kBQFGPznqZa08T6xEpw7XfrjHggj5r4r+mGmag6zCJ6P9reEsUxUtv6tP2Xr4TqQ1xYzc7AGjuVDBUHtN3Ocb7kn01s0+8wJp7e26o9TqJHZ5YeXlDV7GFUJlVU5M7SUQ0RhmHfu4kDUmwJZhYw0VG2/+SyFYV512Ld/MvrcM=
X-Microsoft-Antispam-Message-Info: XOMFa3wo1MUDJIv6BLmTpTvvQt+voLAg0BjQ8xvx+VzWcI2V5XyF9Pu017e70u/D+hIasz1CO8HiTkkTMlkIjtLoOuWbKBrSzSpfni74INRTTeQMFbRzgQZS1Ggowcx60wREhG7sFl5y2bWh+FjdYD1+x4SLqOpRxAwgsPldXiZAlSvrphWz7zXyVUHCz4HCmXJQXj+RF/fW7lS95VaAMI2idrhK/Sby9pB/KapiUq4MfaGmc5EqvtXoyEZ4K4hiBEthXxtnUEtlIt/2SK3uPBgQLO08XN8uCCUx/2cpxYb2MmX7BrKrw4CSf3MRwaaj9RYo0/SqpjcTF1iyvUjby7P16Cd2eK3DIGwVXQIpI522OFkqLyTrl9vWXCy7Mrq6dcAK05sl7k+BMtIJJbzPh4GY5eFswE1Nr4pnV/1Ip3XBb1q0C1adtU9LEfm88dP9GXVBnIz+zRt7aCn4mjIyK56zG7re6Ag1JmheuGcne7IyS17Ooviiz6UEQzyOW42zmjUfNMoT0EgBqAa6a37g2ZslBbsDJcep7avMqANK11Y4xad4GIogwcW7wA8zHY+7GvDK8/Sf48a4RmY+4hotPA==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;7:E1UN3YBoEeg+QoAStJWu2yzu7adxN2av1XNouu3BjcUgOJPBkD8qt3TdVf58linBibKblF19Q90XMhn2LFUFsSxix/w8owBmF61yb4XFMNGFqsEEs2HyLEyee68YX6wi326k2/D2KcVtNwE0PJTVYdx2xFnEIytnARC8dQezdiPA+B/9olcfQu6Pp0NT+3Y2gx5nSdDhWZxDe55yTBDhYyDZyXxo3cXGsg6PZbK+/8429TOteWQN5+iVkklhfVpV;20:uPVPk2Towkb4Kl0UlVLFFHacXPgSoaNrzqW7qdHOD9pX9OiE9ytw/jea5TFHyePHtHofpuqpEf7bL5IYf+PXoGrPzKSz11P7OV2NK5pzguGh6kh8so3kbIoB61f/McX23gOEVVzjxnoqonVEBHDlue17ZTkwtT/84xSqZXhMjs8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 08:57:57.2545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182afaee-0059-4e13-d38b-08d622c4fd9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 06:55:28PM +0200, Paolo Bonzini wrote:
> On 24/09/2018 18:24, Paolo Bonzini wrote:
> > Hi Paolo,
> > 
> > could you please clarify what needs to be done to get this merged? In
> > particular, are you OK with my comment above or do we need to do
> > something with it (e.g. get back to the 'logarythmic search' from v2)?
> > 
> > In kvm/queue I can see only 'x86/hyper-v: rename ipi_arg_{ex,non_ex}
> > structures' patch from this series applied.
> 
> Hi,
> 
> my plan was to apply only 1/2/5 for now.  I singled out the rename patch
> because that one could be included in 4.19-rc kernels as a cleanup.

Is this supposed to mean you're not happy with the approach taken in
Vitaly's patch?  Can you explain why?  I take my part of guilt for it so
I'd like to know, too.

Speaking of the options we have, the choice depends on the assumptions
we take. (And I guess when you spoke of quadratic complexity you
referred to the algorithm to convert the vp_index mask into the KVM cpu
mask.)

If we can assume that in all relevant cases vp_index coincides with the
cpu index (which I think we can) then Vitaly's approach is the most
efficient.

If, on the opposite, we want to optimize for random mapping between
vp_index and cpu index, then it's probably better instead to iterate
over vcpus and test if their vp_index belongs to the requested mask.

Neither of the above is quadratic.

Dunno if we need to specifically consider intermediate situations.

Anyway using a havier vp_index -> cpu index translation looks like an
overkill to me.

What do you think?

Thanks,
Roman.
