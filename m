Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B24325195
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z1tDeHVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B24325195
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeGBVgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:36:13 -0400
Received: from mail-eopbgr720061.outbound.protection.outlook.com ([40.107.72.61]:45216
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753573AbeGBVgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E5kkq3ujvUcNa4yWjtP3rnowe6bPCxGjsgSabMWwRM=;
 b=z1tDeHVPPhPIIodt3zxXmRO6VIEZhiR0V0GGst7eCWBynPeWjWsqNiD4kTRxosAltwCbshUKrMbBV5qG29hBL4PzaR3mMHE/7IgFPZnylPyEyAMnLsfHgwy9x8Qbgs38gVXfJgpmvKcXTY49cwTyBXXUEB0DHYTM6fBwzQWX9sE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from tlendack-t1.amdoffice.net (165.204.77.1) by
 CY1PR12MB0165.namprd12.prod.outlook.com (2a01:111:e400:50f6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Mon, 2 Jul
 2018 21:36:05 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 2/2] x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Date:   Mon, 02 Jul 2018 16:36:02 -0500
Message-ID: <20180702213602.29202.33151.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20180702213543.29202.79104.stgit@tlendack-t1.amdoffice.net>
References: <20180702213543.29202.79104.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR21CA0060.namprd21.prod.outlook.com
 (2603:10b6:3:129::22) To CY1PR12MB0165.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c1d6b78-c523-47fc-0106-08d5e063d11d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;3:0DTFMxX5jY3A78OiF8rwLXQHgAdkEoFcqSrRKX7ZpDZujfIoV+c2mnb/LZsV398VDNPo3a4I6EjAqrI4/szOyuiO+yxeqL98QQ+vqwo90hGK8DGh+OGDtCSYTY0AyFp7OAYlrAD617SWRp3hWRm6dS6Am1lF3LB7+Pa+rQRbq/0DU8cflXob0agfjYJB/LFhVx9ULmZrLbbkE9mm9kUNtuW6rZL4ZYHCW2UlzVIOp+2/a4wNV1KyAIdjQpXxt6GK;25:s4f7/v7IEI3pRW6THNAlpuan2WwPx1o5qrqso1p64D8QIeDjqEO4FBRkRFpVtlaS3R3DsY+sYmC+rvWe9PEWQAiCIq6dm37R0iyVXA/5kV3P5kUdZNXqgpe0P2dSsIk7OZrP5o445RzOjH8KsAzRrJt2r7xZqVmLFjyTy9o7IvISfLePh/l/QQQAg5+qeDK6H5gAychdxkzt758mpCeN/WOmDwNNN/3uOpOT3u9x+2QAfuV7HCav+t/bl0YVZucI/osVg0J09s1lG64bnU0yHLe/o7Ly9x57OUy8hORdkwyfmwY0QLs2SZ7nSM5e3fSdpfHEDOSre0p2HzIo1PKPdQ==;31:QXMLCAydRDlrh9zyrwaz/Tiwt6ikCGcmtLuwbrWKVYZMyrop7VS+0OU4MzqNH9CI20CeVXixPo/XfjgLbep7DvOwCPhSjCh/509BMd/zIZusvN2F4bl0+9Wa1O0EHl3BPFZlP8AqvDOf2pGwIzvlD5m9wHZVs8pK7f5uNJzM+yDIbfE+bHfdNQO4IIOfauYGRbx3F7ag6qKfdNrvvzUXgFznK09GxfgD2Jp0s7BwHYU=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0165:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;20:mhgAlBb0q9jp6MRwkB5nyI2HW9vPBmKdUVSMVYzlRNI9lGCxFGK2I3cHu+/VamekqNwHwxsFBGpDBiyDgq/L38FIFl93xNLo10fZzajwiuCo7WcB4NwM0uZpBC7nRVV5irJOXLVHeNhmAZt3WsDndlCTMppMfv8wOAvWsR1h1vQkvPERivfFDFLNc1B0+M5RFcXeryGpVwXQo87pJ3SwRjb98lc4GdTVfTSrfKcw3FAvJhkfVhsLIIMeZOy8PCxs/Xnfo4GSHjDKvWM5tjY0Y4JmEg7bE+E8tQZxphVrmRgPsECN1NrYC0U8wjvrbTJvHtkaLlGV4AltDJyAWRDMNskfRwybZ2lldKHb1V5MuZGFUgv9HNrHSLo5XciM3GkjLuiPcpBafFNAJ01Kc0uftB3dJAJnibFp+EhaIxk1+X1Sii4wWkjBxD8KGEDfDTJiij/audrVEFiq0jbmj9R9Lun7Bf5dpZ0z8//Coie9ZU3DgKKSsO5gj4EZzPIAiKO6;4:yBuBoktynmgnlEd+9uMjsQ/NTo2mCgr2qvwjCPPZkI8rXpRhNEOr1ShuZaS0kBZ0xe3Mr7HC8QElLGTs1WQAPhJw08H01PT/B1IdVxgSqWeBrTi+VpKqH3hE8G1HPXPtI7zsZcq4nRnKjzQSkI4F2i4aCa4Mi3OD6f/WznIEYbQ17FiDr9gbiw9L+F9y1cYutrGI3uSAHQzvGAHKTWPotZjONsQ8uQCFA+gZCmfK+Kb/MCmYhDnL4l3oOFmYDPV0+StmSaYw5fWz8KkrHaydp7TAxphvpzobAYAxwT+q6fWV4c84p9cH52gjEXtUBRN8
X-Microsoft-Antispam-PRVS: <CY1PR12MB01651233B7D963115588899DEC430@CY1PR12MB0165.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0165;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(1076002)(5660300001)(50466002)(14444005)(6116002)(97746001)(2906002)(68736007)(230700001)(3846002)(316002)(58126008)(54906003)(66066001)(47776003)(97736004)(69596002)(53416004)(105586002)(72206003)(103116003)(4326008)(25786009)(53936002)(106356001)(478600001)(386003)(7736002)(81156014)(81166006)(575784001)(86362001)(305945005)(6666003)(23676004)(486006)(8676002)(55016002)(26005)(956004)(2486003)(6506007)(446003)(186003)(9686003)(76176011)(52116002)(7696005)(11346002)(476003)(8936002)(16526019)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0165;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY1OzIzOnRWYkN1cHVPdmJFdDNHYXlZTjBSOVVtS1Nt?=
 =?utf-8?B?RnZwQ0MrUXRHVlFoNXArZW94YklQdm5Zb0hQa2FlOXY2emhLdmlsM21TbklM?=
 =?utf-8?B?djkwMVJLcGh0eFVPcEFjOXZTTitNWHRQamR0bVRVL3dqamk5SmxRTXdjcmRH?=
 =?utf-8?B?eG5kdFk0UnBBamsrNFpmc1lrQm8xYkN5Tmw5d3oxZUNaeE1MOW1qQXpRbVlo?=
 =?utf-8?B?T0tmTEFocGlFMVNaMjRLSGVsbVY3SUE2SDdRSFZJZFQ5bUQrSURwZWQrVjh4?=
 =?utf-8?B?ZVRxK2lVdGRNbFlDZ0IwWEhpMGVjVmVTNVE1OE1UaUE0VnpIQWJMNXUyZWJB?=
 =?utf-8?B?RUJ2U0hFQUpRd3J6cVlkUTB2OUFlemQyY1cyTEU5aGZTMFk3NWpzTkZEK3VP?=
 =?utf-8?B?UVNzVTJzcWR4cnJOekxWZUxaN2QxUW9keGI1VkhWZFAraXJFVC9tNkkyMEE5?=
 =?utf-8?B?ZFdma0RJRFRGM09URUs5VlJQeE95enN3bkljdGRqUi9HWUxpR3daOXE0L3hM?=
 =?utf-8?B?L1JXUG5ldUNLRFMrY3ZwaktIMTFNLzN0RjZFMFJMWmcvSDM3eW43V2RpQmlO?=
 =?utf-8?B?TjZuWERybGRGTEdxNzdydi9UenVNYTJvbmRRYXRCb05rWlhrN3VMaFl2T2NN?=
 =?utf-8?B?OU9ieXBBUFRqZWlDWERzbElPbnBwT1hrZnhhRGNBWkxMeFFLaThhaXVHVHhY?=
 =?utf-8?B?MHRNVVpEZkI2akZmMzNLZ1JRK0lMZGJnblpqQnpSb1ZQVVYvMmIySmVpUGNz?=
 =?utf-8?B?YTFhL0xnRWg4bklvUE5BeCtIS2kvMnRIdTJGYU8xdzNtY0o3TE4vcG54MEZX?=
 =?utf-8?B?NmpYdExJZURzNHZMKytnaXF4cmdUNXh2bUpvMkNNQTBZcjBYWEdZekFiYmtn?=
 =?utf-8?B?RTYwMkVIb1NRM2kxTTZpUXh0QXFZSlJYK1JkaUtEeEdDZko0ajIyeURvMWdQ?=
 =?utf-8?B?Wldxb3NNSkNXKy9NeW92N1FQZGxsUGZLdmJ5bFFFMmxLUDU4TGF6ZFpPamxz?=
 =?utf-8?B?a0Y4eEYvODIzektkVmhRRUhyTjZKQTZMejdEZzdvekE3SmNtV1BCbkZQUUlK?=
 =?utf-8?B?OHdNSmpCMDJiamVMakNIczFwY3VJTU1JYm9MNG9nSndlN0ZQRGY3c2VJc3N0?=
 =?utf-8?B?ZkRhSlNDOU4zNFZCSmVJa1M2L010SFUzNjI1NXhVNTVVbTl5TWdpK245dG90?=
 =?utf-8?B?NnFIbDhJZFB5RXV2UE9nWE9wQ3QyQS9SYjcxOG9ZcVh1clI1ZDRrdDJ6Wkor?=
 =?utf-8?B?YUdMR0U4UjV2MksvMUFnaXlWK2FnRURMWUhzb2NQQ2NTaHpPek1sUmVLQUh4?=
 =?utf-8?B?L1lob2tqWWFhY2tTVFNkTCtIQXFSaEo5SWVmMnNSN0tiZmt5c1llM1FlNGZU?=
 =?utf-8?B?S2VUWHdabURqZzZYUGtROXcvK3lnZFovOUp6REl4UktaeGNnc2N4UGxPWVg2?=
 =?utf-8?B?VE85WDF3NlErMHFIVWhoSXhHdkI4d3JyU3ZFazRnVjNDQ0pDNjJ1akZNTGJZ?=
 =?utf-8?B?WlBhbTJnWWJ4WSt4SVBRUzduMS9ZdEtZMmxaZ0dxelNrWi9NSUgxTzdyeTNa?=
 =?utf-8?B?Z2wxY3k5WWkrVGlXVGcrdWZQMjNBZUN1Z29WeWxXTWFRNERGcTVZRU1OMWlQ?=
 =?utf-8?B?ZjNySE01dURuZ0JUWjV0Vmw0QXMyZWtxaVk5OXA2MHFNcHJ5TzVERDE1Rmx4?=
 =?utf-8?B?TEhhblRkY1hJdlVFWmNaYVFORlpBWU9oYkhSLzF2bjBaUlJ5RlYrbkRLY0lH?=
 =?utf-8?B?Unc2MGZ5YlNxWXBaY2JRaEhFclFJMHNva0VXcEQ4UFBPVDRlVHV2MDZjQTM5?=
 =?utf-8?Q?P5QM1XMZ+sqEW?=
X-Microsoft-Antispam-Message-Info: YfrCCG2JSqtd4+I2qQOxu1ueuwvAn4q6CInnNldjS/ZcUOq5RkSFyn77Ins5jeGkLaHkHqFDJ4udSaD5JpkcF/cny17JEHH8WssGCrMrX/i7Pytr7TM2Cu01eHv4+HAodwua3iWFE32DmvxiEbIvHHn9J9uKA9N76dd3ex65cnRdkhftaEqjzX9t7+uyjuYTect9xa2BTrqPGEH5rLMpI3vzQgAjBuoog8xqvDBkeiU9Lmu1FBYRCysWSgRsGRZ4JKoQPn0/VKg0+/Co7NJmpn+SmHqXTDsvFT7ZwXXrujdQq3fS1hFSa7FjM63/1Jy17zu0LklpE55lNJzlEB9Mk4CylZYYxjYUgzNH31frGjE=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;6:e04TmkBsQgVRbpXcWtJctzLROUao1Jy58w1Cb02h7dBC9IbkZeyUALZ6A7EdHLEAIAD558+ceGM+aIaA3j5wdbT/khf7DDfJuyJ7vG93V3bN83CJie4pqrv25hjGOX3GnlsSxGvNzGp79MWtoZa3FeEfaCQn99DLgKso3OQDPAwlbQH4K2YmK7H7HS/FNTqZogRdNfmwA/p+of4uJMfB6WZCh2OvUr5uMc5TY6dWhjiXLkDJ7qCHJIPk1bS1jlAwBthWdIAkQYu8byUsPWRyebE316zKnbU+cCyg3dxDYKWgBYyPqBQgX7xIcyj4A7CO25+QwXmc+x3GkeN0n72Hel9kxL5wxf+Z4A8c07U1UWwcDU/qQY/8JXgE/a4h5vEoQ3tQO+xs5mboIi/JpQtN1R6P9JatNcYWbBa5zNv0ksMpySchnaqP4AMd/x2CWjuO2Biu76Jw5+Y/SRtIMEzDUg==;5:Yi31RC4hF7Rtp/3AvymqG7lIserO6PkqwA8CMZosbGwS+fVgdAsyWpVh677GW4yytZNEvrprBbIqnrYjH9KLoINUZeq32ctnZKlbqxMZ3/buWPm4Fz7goIJfN7BEjlvxqqKa7yAcA9CIgAFppVrHVSnckco32E47JL5GeZpCswM=;24:2i5hYz7PgUFLT/q73tn2KrZ3K7O+ryNjWS/puFgU7fJ5iqR5JHmgOi86lp+urFDPgzg0GbVjJEfk9oIVSk6Xwhmr9OSYmVXn7bv4rtHGIPk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;7:gAN8kyQ+TE5FSj6P0yjUNn4HVOTjpqyj1+0gNA8tDvrrRgIBTlH8UvHn3WoVRDmc4OD7MQegohG6pOmHVCOOLbUiAYoudRUEmOurAT4KaRoMiAryfaMSTQ6p1FFsd2/xcNiWRe+gJLP+V/Odin/o9cz8mw4AszfQMIuyBXQ5oi0DuuU1593lak/cpv7nbFgDR9y0hHP1CEzgzALvpdi4IqGP1zd5/IRuds4tP5ATPEupYGhzbvVW7ebpojHo7Zmu;20:lLFPDZfL79exrB4s7zAnow1+i470Kwc1njnEdYZe9gAWNS22J2zKU9vTsY/DL9P8n6JIJw/r/vtweMdfJui7+PVsVDrpV/PPRLog3FK1B8dIVjVOcbrWWJ6yVD8G+o4bPk0vm9ZcSE9JfOPuT1Z86khRWoQ1xdfLrKkX8b6dEXkillQ11YKZ7bb3fEYABD9DFMJr0M85cus6HRk4vyDBGk44QJUl8nAdIeFgAgkxBo4kdKgCUw6NRJFN58P1BZmq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 21:36:05.2712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1d6b78-c523-47fc-0106-08d5e063d11d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD, the presence of the MSR_SPEC_CTRL feature does not imply that the
SSBD mitigation support should use the SPEC_CTRL MSR. Other features could
have caused the MSR_SPEC_CTRL feature to be set, while a different SSBD
mitigation option is in place.

Update the SSBD support to check for the actual SSBD features that will
use the SPEC_CTRL MSR.

Fixes: 6ac2f49edb1e ("x86/bugs: Add AMD's SPEC_CTRL MSR usage")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/bugs.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 404df26..5c0ea39 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -155,7 +155,8 @@ enum spectre_v2_mitigation_cmd {
 		guestval |= guest_spec_ctrl & x86_spec_ctrl_mask;
 
 		/* SSBD controlled in MSR_SPEC_CTRL */
-		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		    static_cpu_has(X86_FEATURE_AMD_SSBD))
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
 		if (hostval != guestval) {
@@ -533,9 +534,10 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
 		 * use a completely different MSR and bit dependent on family.
 		 */
-		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) &&
+		    !static_cpu_has(X86_FEATURE_AMD_SSBD)) {
 			x86_amd_ssb_disable();
-		else {
+		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);

