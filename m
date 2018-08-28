Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6D720847
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NS37cI/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6D720847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeH1Vs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:48:28 -0400
Received: from mail-db5eur01hn0203.outbound.protection.outlook.com ([104.47.2.203]:45121
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbeH1Vs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rsA1oI5adDBV5F8WsxsFH0n74QZsxx4OLVisjFjTx0=;
 b=NS37cI/+V9n8XCcm8PJTJ7smE6MAnjglirxnwW9cSbdNFXHvgj2f1L9i0dR/WzpkDSqegWXPZm9lM6kYDwtKTl1x+aTYnr3VeWltlvNjg3IXzPsbu5UzUQOSivy7UbxFnxX8SKwiSDQkAYmhaK3EP19BwuLu6oNUMMLy6MxvBfw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 VI1PR08MB3597.eurprd08.prod.outlook.com (2603:10a6:803:84::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 17:55:28 +0000
Date:   Tue, 28 Aug 2018 20:55:23 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] KVM: x86: hyperv: implement PV IPI send hypercalls
Message-ID: <20180828175523.GL2326@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180827164858.12496-1-vkuznets@redhat.com>
 <20180827164858.12496-6-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827164858.12496-6-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR08CA0238.eurprd08.prod.outlook.com
 (2603:10a6:802:15::47) To VI1PR08MB3597.eurprd08.prod.outlook.com
 (2603:10a6:803:84::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 401c5a75-cc32-478e-553b-08d60d0f70e8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3597;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3597;3:7zK5A+1gVmQDsSueDeHGYQTDeb7H6apM06+lpPwbZ/FluajyQhmafJVH212owwsRTpDQUqzTEUxIQ/nCnAHpFEaUG4Jt8U5U1I5TWct0RnBvwFCdwunkDTSDV7M8V2W6U3h8JywxzUtm6aVbDgGyr8TK8p/N0JFsitUGFdPqMvICeCdgcK7smo5S0unNMKjKAtJ3Ty1T5gFJLCEXyDHPCVCg9qEj3DqjTQOUODLBrJOfgrEt9J1dex3HIxv56f3u;25:pwlsTdFiLCYeooeLTpIBE+WsiFUYsFTT3eySaa6YoeABkI7Ut+Ep4tB0FOkjqF37IursvO/Bo4o4tjLqBX+TKpwOoy397PM7KuO1aQ6S8APYQT9hAMyeFQEJHBkiK5I3sN0F+p3Rhsruj2DrLS3ePoF1YtmZJhljK0Z2B2617W8W7m/cn0x7dEbGtPAQ+2kWQnwNPWAwpRe4h1+xOmEmaEgQz2d8895oGmO4gtTy6GXlncDeNqoGqO7l80iWl76ADLxt07B2OQWmvhpWKHLIZ37+U0tBwIilLgQX3l6UuBx38QN1DJRcu7Cf6PP9Wc/zkDnZ/LYQJxoJAOLUUr7VCA==;31:LIIIN/yWBte+jh59Br4wAhhUnTQy7tF6LKrT6o6MFVPmUKF7iK2yHmN/6ITY1Oh2G4IJHdIzuQZrj+y2RPJUzFvZ0vHq6o0RcBtFSo6hhDIq/IV46pVjvR2DXQSl6M3+hLZuOJ4U/s0oBq/9YDq787LrT6DL4zy0rcIyRwirqmU71mxjA4ohYSSSEeDxVtUxIpOJHdXQal7q+rBmCA6ogdkOsmfPPfGzap06GnodNes=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3597:|VI1PR08MB3597:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3597;20:Juui3x6InIVMj5QqI9gcmGXWcdDypV+hIVclNI6Z1ICno8XEZhv5NN0nGQLhXfkhPGv7xUQ2TnQcBBmyLdVxO5n1HP38JTgXZsWb2UQj6CSo5JYU0MqPa0fi1PvO18J90hOschaFMZR5yIsReWEcocLpipME/QVOAl+WO8hQHJ71tLLSemUDrzBPLVNutXja+szLfujQnDpgoD1dzRjlLvpBOT1sLwcium9tWfKysI4gS2/pdWJplhHAo/xYQNxkN+4UrVDuGdpu/r7fmoYcr7ZgtRciD26Zj+aBnJFlifYHYlarfMAEZjH4gTl1CiXbc883Su1LVbPkHsoIDxpvxqfWqJUmZR6owdycXsTKzO6WBwWhX4wX3flBbm8VRhhTqCUJDAWEXYTl9ccxXF4LvzLClP+XFktkIZjg3b4f+KiE+IRxDjr9Qn/DYHt70vS507hYUN+bX49xqrH2UTJZetbwcuJlA9QQDOGUqjJppmsSv0JEUQZarJBER69v422K;4:W82pE1l3wXAi92KcHMQpYBDbGgtXlxLxDdZrAc83UvGxAVxiR7lLKgkNZIPdm63pBX4vOFzEWrZrdhfE22gSnxwpxxcWT77Whdt51gszPl4Zh6FxBAEleaQS4gjiandLOSdw9UR29/cxM/sAy+qIhSd5bNw9OVSluiyI/7RLCKdMlRxjuL657PZjCqMbX1vj5Gf+UJkBTVO044+L0MICFRSVtDz9JJEKuSUG6HvLU4IJoLLyvk7Twuvn+pXCZbyx6Zf0ucFitYJkE0r4i5DCPkMtmkHLpQqWgRhmToYS5aXCCJzF669jgqnRO5s/U7Ue
X-Microsoft-Antispam-PRVS: <VI1PR08MB3597FDBE4B46BA3FC5ACED3CC90A0@VI1PR08MB3597.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:VI1PR08MB3597;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3597;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39850400004)(396003)(199004)(189003)(3846002)(6916009)(446003)(68736007)(6666003)(53936002)(305945005)(26005)(6116002)(7696005)(7736002)(81156014)(486006)(52116002)(39060400002)(8676002)(476003)(6506007)(386003)(2906002)(54906003)(76176011)(81166006)(11346002)(956004)(23726003)(25786009)(55016002)(4326008)(229853002)(478600001)(316002)(9686003)(7416002)(58126008)(16586007)(575784001)(86362001)(50466002)(16526019)(6246003)(1076002)(47776003)(105586002)(106356001)(53416004)(33656002)(36756003)(5660300001)(97736004)(186003)(66066001)(14444005)(8936002)(69596002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3597;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3597;23:02UKRMsp8ba2G9rpYsCzHCjTfVi238Lpvx1UgZhXP?=
 =?us-ascii?Q?gm0ssL3NPPypFG1Ezn86zucT4inWyqGIarmyPIbqu0YJLSNTgoErB9ENfR93?=
 =?us-ascii?Q?13LU/CUNNasA4TPhch6lY2zN4JQQM/Hy/+aMjTPILIzTckcviq3qAZl/iKaL?=
 =?us-ascii?Q?NKeuG9f//G/WR3VF+nbD7adjnUZCE4/JoK+h7fH7ClwQqVjg4sERxU0dZZzQ?=
 =?us-ascii?Q?DfmAbZXzwuB36WLfOAdIqGRCc3kinqJMq7izTnxOVUF6A6g5SBp7qA5Kc3O7?=
 =?us-ascii?Q?fMaSGT665faBYI8SmvFic+Z7KbfGxM8IB2yHm4vJGjRUxsr2d5Yal811Kypj?=
 =?us-ascii?Q?bT1aptGR6kqYydZzuJ8ITK9p6cggzSooBJqTEzPZmBsRy5QndS4HCgmJOGRx?=
 =?us-ascii?Q?pTdI5wUjk2TIH0qBN2WJovcbHyjJ4yzkHzjJVYcU7QVKfhWWZCcquKKdaI/E?=
 =?us-ascii?Q?3BqbcuWhavREUfpG7WQPGhIcV1XARO64JHaUaKBF91bMqosD0jEnd/CBXszA?=
 =?us-ascii?Q?z+QzFfm3EwOmPgiu9+L79Nkx9wA8/HocPTF65wN9oblFfMcrSwA094Qgp4ZH?=
 =?us-ascii?Q?O+nZTOcq13zWEOHFvFH19vIhIN0KEGFBelgg1Jb3v7VqrL/IN4DCDGLuJgqA?=
 =?us-ascii?Q?k0kxhuJ9pzszsMutyiPUtf7hY/F/498skaSCDad54vBOWCzmOd2sttf0r4Da?=
 =?us-ascii?Q?3DgrIx+GWNgxewUgCGvVUn657J9D7kpKEjDmYz7GmXKxWwNo4A94Ded8jatn?=
 =?us-ascii?Q?bPCxeM4V1AQHJnSfzP6cKppoL+bB8RzxtVCAZagqq1QQmyv6wLWpGs3TO7vY?=
 =?us-ascii?Q?qDMQqMFDwter1AJ6Oacct+ca4U5SNJ8eQI4nXjhn4K0BAJzI5x5M/buoUXhd?=
 =?us-ascii?Q?gah+6wJjn8Zyhdnr4RT5oybqFglYpUB7Jcgw+O5i3HfXx+RGbsqR7g+j+ceD?=
 =?us-ascii?Q?cTr7shgtH1vHTXQh9Xr3k36eItq7gKtLgsDRPbOt/L+1uEystBf84UnnNtbl?=
 =?us-ascii?Q?EGQG71V5vIQm60BZruLXGAMh7fwYPGQ5A22A2xp0U7m12bMqAY252K/GM0Ub?=
 =?us-ascii?Q?0hMUvlgBCRw9Z8/I1sa7KmH/+z/OyLbW5zFrBwqE7ueCVS4uvf/nnpc545Zq?=
 =?us-ascii?Q?KasY+T8woVutkO+cIZ7FQw5ZWXPqUUq678kolNqoZ8LvrSO/8J3CN1DIyuTy?=
 =?us-ascii?Q?yiH4Fy4hCttms0TCuCbzbBe1BpjEV4px4qSmwB5PF9XoX58jULWygT5z3JpJ?=
 =?us-ascii?Q?7DfhDmbvM7ygVnG1jIo7B+OZWSTSDNwVqK+z/mkfIS5UBlX3MNFKL7LcqxQf?=
 =?us-ascii?Q?yBQlcotHCNx2KomA1xysstvVwjKZTTu0PlgYg2Q5kMzx/GchKoZtlP1ZcbAj?=
 =?us-ascii?Q?r8fuNRZhTh4l41Jx4Xiv7Ot28+Px0eoYgf0YCCIByghlv00tYYFlxS/iBZAn?=
 =?us-ascii?Q?yUq6xGEAnwN9Yd4p2+LpojMVFqymBQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3597;23:s+cU7nbnkJDeoHeuckHYt9RUUgPvpIaVO8vWoe6DhGMH5bre+gat6J0X+hT3JH2g+bz/cYVvelLSQDgbQcmSOIWAcqRIxlsFj+fTYU0tbfXaMBHrlO8o4WHByr/K1Npe4XZZZFwm72IBBBDOBBIQqg==;6:zz94KJMO/2wwYIXq0cshF5KnBaGbJI4GH83C2W8GmYOXPPOed40g4ylrw6VrosiEhoeXjKpYHBMqLNfn6Bq5etLD5Iei0ta5hB3Z35DSJVxfwACmMWLBtn/+6K4q+TSzaFhLYtRBEj6N5VaV/UTZ7PyDFAtGjxbEv7OPi5KbS9RYvxzprrduzX+fY4iJNItdpbXArJ9NAOBqsWi8pkBh75ZeIelUbJkmUy1SKL/ghCX/PMF70G7suIvx93R23ycQdxywbzq5bz/Wr+Ku/nvwbEb6reBxQeO9pX2fa1GcyPCuNbVKRKCzzix3f76/+hSswYcPnqLG3rxJtGUPyoq+bGq2JQxSMw0dIS51vMygZOKqudSzqp3A3rEhbsRUmhazTu0KxuCTPkDR/HbpZj+ZZYSwvqVWXjL3dQ4bsdSeHHFqi2x90QD3YL9STU/UWAX0y97I84e0SsyBFSPtDjj8DA==;5:AtfHO6qSOtD518ugbkHjNUU+YTyhIwhxNEcqjvsuuXsb+ogVMp9ZS/Ob44tejegpB0J+GLG/5P2+SgK7ZimHouFzYwVJ1XSu0r49LXXZFY1gjsulE+FpZOUzYyBFd0VsVyzuxT2FYdFmJ4XJyoar/Y2KaP3Nv2up+tE41prNOf4=
X-Microsoft-Antispam-Message-Info: fd/wja1iMOqt1niHrooaCY5DcDts4uimMhDJJw3IphmvXiwMFomVY+jLE5Z5QofA+UC4gKwlKfYS0tHc+18Fl6aw/fa/WzFKmcFn/dXbG0/CWvZkembMRlLb0IurrhhL3Vjcs+jyLlJUZoz6G9Pe4xosKLonh4i7ng5UPuYupFmsEhnaPwjBAhwToNARSmeTVy29L2pDmWV/mSJVzF0wqftLFMBaqB160vHrvActyuoBD+1IeGf/GGYRrn2o3eKA27JOLKynMDrnYi+++4jBmW9JtmVC3+X5YBPixuE4Exug4OXRrOC0XN7yLBgYevC/wuJ+xCJvNHaO3MSKFYu/7heVp2Ox+Dy+IHYz9E1TpN22vKOIqMndplvYBi5zv0HbMSHEcXQCZK7RPZZ2KX8V6Y5Hq3yLxxKIbz6waRNqsLxFsQKPV8aGU50w3nBI9TUUqW2p1uevMwVPiUHafYdRP94IG3BVdrxOK7+ekHpDwWdjmYDv7c2ZEbeffZ8P8fp464TIbeM9mZzwS9RBD0JukIUTMg1tDCDPQWkH9tO1EydzJwUBLqNK388/7qvNaa1/ldubDnujvPfd6yE5zi+w2Q==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3597;7:vU98ZLlEwXP/p8AutskFmuxNBdd9Ooegk+ezFHEbA1JuSGGp8j4VR4vVUmNRTGkUbSH5d/8sPZe5mZqqsBBPelQ180hTsMz2ZqREHsrdQsU9quSq6akdgPUXMCAR8rbaBVuvQTSaxNqA9jvoFIgfBljBysObAcJ08iesZ4nOpG/jLwYqjAJSfYSRwQBmWPBCKuJZNSgT5ocYi7v5QT/rkpSXhP9sWPAEfQwGfw+eu4OfIyhmdjZ473d1wkmLiKI8;20:zbAY2Ph3S/Q/6Q1y7pio97X5gYrrCKQyRod+kY4w1c7Zmv/+ClSSspePIg53DltHzi6rIPQVOPcb7npC7bw6oV73W3rrQUbmJwX3jOhqgfTudr+cuTmNzhoiCsqCvqKwNNDq/btSVWvB7K4TfEPh8KJlQ49xaSFi7cG8unkHeKU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 17:55:28.0592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401c5a75-cc32-478e-553b-08d60d0f70e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 06:48:58PM +0200, Vitaly Kuznetsov wrote:
> Using hypercall for sending IPIs is faster because this allows to specify
> any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
> will take only one VMEXIT.
> 
> Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
> hypercall can't be 'fast' (passing parameters through registers) but
> apparently this is not true, Windows always uses it as 'fast' so we need
> to support that.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  Documentation/virtual/kvm/api.txt |   7 +++
>  arch/x86/kvm/hyperv.c             | 105 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/trace.h              |  42 +++++++++++++++
>  arch/x86/kvm/x86.c                |   1 +
>  include/uapi/linux/kvm.h          |   1 +
>  5 files changed, 156 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index c664064f76fb..d6fb93f22c0b 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4762,3 +4762,10 @@ CPU when the exception is taken. If this virtual SError is taken to EL1 using
>  AArch64, this value will be reported in the ISS field of ESR_ELx.
>  
>  See KVM_CAP_VCPU_EVENTS for more details.
> +8.20 KVM_CAP_HYPERV_SEND_IPI
> +
> +Architectures: x86
> +
> +This capability indicates that KVM supports paravirtualized Hyper-V IPI send
> +hypercalls:
> +HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index d1a911132b59..dadec987a39b 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1360,6 +1360,97 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>  }
>  
> +static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
> +			   bool ex, bool fast)
> +{
> +	struct kvm *kvm = current_vcpu->kvm;
> +	struct hv_send_ipi_ex send_ipi_ex;
> +	struct hv_send_ipi send_ipi;
> +	struct kvm_vcpu *vcpu;
> +	unsigned long valid_bank_mask;
> +	u64 sparse_banks[64];
> +	int sparse_banks_len, bank, i;
> +	struct kvm_lapic_irq irq = {.delivery_mode = APIC_DM_FIXED};
> +	bool all_cpus;
> +
> +	if (!ex) {
> +		if (!fast) {
> +			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
> +						    sizeof(send_ipi))))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			sparse_banks[0] = send_ipi.cpu_mask;
> +			irq.vector = send_ipi.vector;
> +		} else {
> +			/* 'reserved' part of hv_send_ipi should be 0 */
> +			if (unlikely(ingpa >> 32 != 0))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			sparse_banks[0] = outgpa;
> +			irq.vector = (u32)ingpa;
> +		}
> +		all_cpus = false;
> +		valid_bank_mask = BIT_ULL(0);
> +
> +		trace_kvm_hv_send_ipi(irq.vector, sparse_banks[0]);
> +	} else {
> +		if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
> +					    sizeof(send_ipi_ex))))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
> +					 send_ipi_ex.vp_set.format,
> +					 send_ipi_ex.vp_set.valid_bank_mask);
> +
> +		irq.vector = send_ipi_ex.vector;
> +		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
> +		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
> +			sizeof(sparse_banks[0]);
> +
> +		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
> +
> +		if (!sparse_banks_len)
> +			goto ret_success;
> +
> +		if (!all_cpus &&
> +		    kvm_read_guest(kvm,
> +				   ingpa + offsetof(struct hv_send_ipi_ex,
> +						    vp_set.bank_contents),
> +				   sparse_banks,
> +				   sparse_banks_len))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +	}
> +
> +	if ((irq.vector < HV_IPI_LOW_VECTOR) ||
> +	    (irq.vector > HV_IPI_HIGH_VECTOR))
> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	if (all_cpus) {
> +		kvm_for_each_vcpu(i, vcpu, kvm) {
> +			/* We fail only when APIC is disabled */
> +			if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		}
> +		goto ret_success;
> +	}
> +
> +	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask, 64) {
> +		for_each_set_bit(i, (unsigned long *)&sparse_banks[bank], 64) {
> +			u32 vp_index = bank * 64 + i;
> +			struct kvm_vcpu *vcpu =
> +				get_vcpu_by_vpidx(kvm, vp_index);
> +
> +			/* Unknown vCPU specified */
> +			if (!vcpu)
> +				continue;
> +
> +			/* We fail only when APIC is disabled */
> +			kvm_apic_set_irq(vcpu, &irq, NULL);
> +		}
> +	}
> +
> +ret_success:
> +	return HV_STATUS_SUCCESS;
> +}
> +

I still think that splitting kvm_hv_send_ipi into three functions would
make it more readable, but that's a matter of taste of course, so I'm OK
if Radim insists otherwise.

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
