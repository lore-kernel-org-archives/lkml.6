Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAE820C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NGNQYf6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAE820C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeGQNx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:53:29 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:45079
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729671AbeGQNx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+0nj+3c3Nt9IrDXDnf1nHhj96rHh61epyJgyc2ACqM=;
 b=NGNQYf6yHD1UN6xnbR23Ri9Jg16G8ydiVSD15DO78LZlcpXVdfVYCKCnJvLdY4hyF5P1QZalmGhXPw/lXT9B5hrTfhFylpcrrIf+F7pyLTi32BL/huTSXLL5/uEMO+iS1NdsRl4fwnJeFh3brvr25/UafpCXXmR1Z2uw5zIoTM0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2017.eurprd08.prod.outlook.com (2603:10a6:203:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Tue, 17 Jul
 2018 13:20:28 +0000
Subject: Re: general protection fault in list_lru_count_one
To:     syzbot <syzbot+50d322b3e0b15a4a8d55@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, garsilva@embeddedor.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, longman@redhat.com, mhocko@suse.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
References: <000000000000d8cc39057131bbcd@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c7860eae-cb7b-07fc-ff8b-b0bbaf04bdfa@virtuozzo.com>
Date:   Tue, 17 Jul 2018 16:20:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <000000000000d8cc39057131bbcd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0066.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::34) To AM5PR0801MB2017.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1541b8ff-6c23-4643-8339-08d5ebe81154
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2017;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;3:8AgGBl537O/PlpCnlhHuPZuSp0htEFyXsHw5RlR1q/JAsswvAKgnWxCRZElX1GUYk65vJP7M36/Ss7cYXzu1V6KWDnCygzwUBzWPXUtOmpxER3mT1s1akiNhT7wMsBwx0h/B8Wc1PV3S4Aee35u/HmaCIhCcJ4shi10W0ilaoW3PknZgAa25n1/Yw6eFX4hVpZt1yEjcDLKIGb/pniF6OlY3ssPuqHqYHc2f6NYxh/tQL/m0EfWJG4+D/CW7WRDc;25:+ajzJW7FOod/yRX60jq2NtVk9W4lzZfQ3jy47QRj/bDWc4+l4ZTNstyo2xr2/sEQLnYkiZoRC3MoE8TdjLDtWAKCaCEZGgE7eL91SMOxpytOSDHFRIMxpJCeTeha7L063BVgJJ1cblOWkxmmtUzldOsZJY1oT2vLKDZHahFZKewy8Eu3Gyie0gtjYD1BBmlSdahuIR0WCUXv1Skvthu/i0penoJ6TplRUywiWyugN0gYLHdLGH8K6DMZTxVhcL1JVOMfeDFS13u1j+05cWdYPJRiCUJh5OAfNvgEN+iVCQXmkakYPmNPurpCUDr0pELF9bxrOS/9vOj8Yy2RM24PmQ==;31:8748z81irSFJMk7wZm5sSG2aOBANfQD6QgpGa2keWiYg4LrWHqDNomjPJ85HAb/oTiTkmpFAQGxeRtpK3ypowWZA2JtBwcj533WNJOPdzg2dGpy22F1gSXQZL4hjh2bCJiaMxRz4SzZwyHImpcPJcgvN+zXDX6ExivM44bLaAPqV3bWIc26aHCrP0g3yywRgH8iaGcwvjbe2ASj6iCPtPHFJLt1l0ZHKzP1Fq5Zsr+M=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2017:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;20:yHuaXt65YBl2PLab2lPNwzoxHCgIgu8qiopn9K9VToafphygjL55y1W4YIkj2U9J12CJWOam/zmX2/ek535j76Hb47Jym9sATpNqZCqvHxg3WeXy1G6wg4YMDnEEYc2dWUPpT838N5ABPyrT/cEAb1LYW8jZzspI//Vj63ys801oF1FO4ahN2vbvWX++A2/8wOBHROVTM/dx67uxhuCrTQeo0Gllx3rq97wBLeq5VQDvmO4cjv2EWsrUPT1cC4PDSoaYzImwLfRH5cGmFOjS7GdtukknmpRfxa2Fdq34O0RVFBDejRYJTJwIytR1VI8FfztmFKlYmuopjmsXdsSahZJsvRFMSiAjCNzVLoBYeVKUjKSwGQd+tNuuDcD8D/By+YID0Ns6b/OV4wfVYos7xX7TYzP2zahKCnHmrWSusN/PMxGz1tKBW4/K7i63GlKTDBFTNi/L3epKQTSiAEon9LAkkMQ5/guXMChO5kInSANsYedfXkUNDcae92VBAvPK;4:F7jVCjfXK2+ido1CAfGlRP13mqbvVOGG8agjh48BawwwytCDdK65uGXcJtyomicPREXQr3auusTZKUHrkPclEytV7zTMkSWSxLPllmql7sryW7FFzbf4GmDlXiTYkMcNy7j6hVEWm4VR3Yr9N+fvmU1INjJqqR4BFoQ5gX/0hiKNnbsVTBlFDmqKrN9n/IjtR/rruP+sUnwjVIwu59n5EfMIoJ9fPvASMaaXRJypgImRSWHIEQ8ZGGLrJE7Yb2qKrkeOkIUmnCyB7pH07zmmhI0iz+GSLDwK3nEJ1K1Ndnx1+nQccFMMLrysP/9YZjIS
X-Microsoft-Antispam-PRVS: <AM5PR0801MB20171E04E0DEFD11C0A2E166CD5C0@AM5PR0801MB2017.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2017;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2017;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(366004)(346002)(376002)(39850400004)(396003)(189003)(199004)(77096007)(64126003)(229853002)(478600001)(86362001)(3846002)(26005)(52146003)(6116002)(45080400002)(6246003)(386003)(2486003)(52116002)(7736002)(76176011)(305945005)(6306002)(575784001)(966005)(23676004)(31696002)(25786009)(8936002)(81166006)(47776003)(66066001)(65806001)(8676002)(316002)(81156014)(6486002)(65956001)(53546011)(53936002)(39060400002)(16576012)(16526019)(58126008)(186003)(446003)(14444005)(68736007)(956004)(5660300001)(36756003)(2870700001)(11609785009)(2616005)(476003)(486006)(106356001)(7416002)(2906002)(65826007)(97736004)(105586002)(50466002)(6666003)(31686004)(11346002)(921003)(99710200001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2017;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTc7MjM6a2N0N2V4aWxOWDdwN2Y3U0ZJV21uVlg0?=
 =?utf-8?B?N3BJOEQ2OFFXeHlCM2o3Z1ZadWx4QzdNWEJ3enJBSmpVaTg2SklpMGRVZEdD?=
 =?utf-8?B?MGNScTllS1RIVnJNWUw1emlVamY5RnBLYmlXakpXak9Gemp1TXBjaFBPR01q?=
 =?utf-8?B?Q015dEUvUXZsZEIxNTI5d1pmdE5PU0xna3o1dzJ4VTZ5M01HWlFxayt6K09P?=
 =?utf-8?B?dFdESWE1Mld3NG51alJQQnBqWVh3Ti83OG5sMlBWaWdqK0NlUlJhaFBqMXBR?=
 =?utf-8?B?clRZeWZlcTBMRGQ5NGtkK1puWk1EMXhKZ1hFTFVEWnkvRjErMmxzcGlUbSsz?=
 =?utf-8?B?Kyt5bEppSkl6d3pjVmVubFhFZGJLMXFKa3JRTEhrQ2p1aVhaS3V1YXJ5MUds?=
 =?utf-8?B?TkRSUnk5TkNoYXVCRlRBYTJnRDY5dlhaODVXZ1BkUDV6alVLWEdEbGk4WHBn?=
 =?utf-8?B?YjI4cWhUZXlsdG5tbkF0OXBETDBCcGdnRU12cTFIaFFhSCtMbzFTQlFGbW1S?=
 =?utf-8?B?NzUxbXh4eitZbGRHQU02Q0llbnNSMjhPelNSUllDMDRDWmFPR2NZOWpzSEZY?=
 =?utf-8?B?VU0xdHk0ekpoM1F1aEtXVFFmKzJNcmVrd2ZSaUYrUnJBUTZIRWFJeEF4Rzgw?=
 =?utf-8?B?M2k4MUYzTUxxb2lZaFEyUzVxWjgrVjM0SlJ3ektPSjBQYUloSHNJdjVVSzNN?=
 =?utf-8?B?eTgxNlZQSVhrTHBDakNEUHU5aTdvdWtpN3h4cUhvY1I5cHNzSVJoZE9xUGda?=
 =?utf-8?B?R3ZEL3haanJUSXhzcEJsd0lmRXdBaTh2aThMQnJPaHQ0OFlsYWVwWGhiMXRn?=
 =?utf-8?B?dGxsKzNCRnlYR1d0U1AzUkN4V0VteEErMDFCZzNlbUFaTGllSElucG0rOStB?=
 =?utf-8?B?QVp1S3BRbE5XbTZoYjIxME00UGJNcm0xekd2TGtYVENPUHlTRXdVV2xGMDQ5?=
 =?utf-8?B?Z0lhbVJLdkVuL25xZVZ1ZHF6dWFpRDhQVmJ6Vm9pdXRyYTA5ZXUwakNocjdZ?=
 =?utf-8?B?VEdJdURHM0UrVHI2a2tYVksvY3lFTDFCTlE5dWlCV1ZqdXhpQmFrWE1EOEpL?=
 =?utf-8?B?ZjRUT25TRG5hcld6dU4zVnkvSHJrZlJZTW9LN0hOSVY5YTBuSXh6Tm9SME5M?=
 =?utf-8?B?dVpJNmRRMUVIekxRNzdNK0RGRVZZcTZ0RVJJSld0L1haTHlHcjZsSmRZcXFS?=
 =?utf-8?B?c3FRK3hkOW1mbXJxWnFXVmRScS9xQ2FyRUw5WmFuN3VmRFpYODRUZnYzUlh6?=
 =?utf-8?B?OS9FTFc4SU0xWVdTbVlobHBXUTRYUUw2SFZsLzcwWVNDV2YwdmZ1aWUxTmhx?=
 =?utf-8?B?Z0w2SThYZEM3THl3MkJrMk9TVy9VdlR6aTVpRGs1cHhTdU1qZVE1S1V4dWdX?=
 =?utf-8?B?ckdpR3BBc25DaDA2bHJNc3Arc01RbExacTByY0xlbEFQZjZJMUNjUWhZRUM3?=
 =?utf-8?B?MVhPSnpkdmsyNjZRU0Z2TURjclJXVFMxbm1OOVovYWd6RzRJTk0rdWdLT0o2?=
 =?utf-8?B?S0VFQ25DTGpuVTB3MC9MU0VnM0ZQQ1JXMDVMK25LQzBsaWQ5L0tHSDh3VVZs?=
 =?utf-8?B?Uldwa0pqM2VHQkxZU3poajhEMEd6QVVEWE5ZUnVhQ01wUGxSMG1ZWStIUzVm?=
 =?utf-8?B?WHl0bnpKYlZMMFFBVzJwUEVSSXJ5Ulo1aTM4M3dYc2NsMHNPd0Rza1gwZGc3?=
 =?utf-8?B?NjRQcnZxWmhHZnpQVmtMNTN4YzFkWnprYXl1TWZET1Mzcm5hYzU0cHZwdFF5?=
 =?utf-8?B?aGRYUGtkNTJYWDVMdjNNcUJ1R3dWYThReVdVK3g1c29lK0cvdFYzeU4vVi92?=
 =?utf-8?B?d3JvNnZla3Q1UkpTMCtEWGdKNVhNeWsvcXRUenhVZmg2RGpMRnZvN1h4STR2?=
 =?utf-8?B?dHM0b2lOOHQwNjhhQmlzRi9nanJoUnNwZDJYTlZDQkVTOEl6Wmh2T2l2UTZG?=
 =?utf-8?B?d1hNdDNETmVpN2VSVmt1VEFrTGlybzBmdVhmdUFUNFhnV2JnMW9DWVpML2ZM?=
 =?utf-8?B?QnlzTG9IQ2w4eTdNNlhSaG1LZ1d5dE9uS0owd24zbzl2RXZoeVFnejg3Q1RR?=
 =?utf-8?B?MWdZRFllNkxkUHEydnZ1QUN6NEttOS80OSsxWjgxaE1TWE9DaWhESmZGd05N?=
 =?utf-8?B?UG5mcWNIYTF6TTBCaDdnWWpKOWxmTCtOSHJ4NTdFRjZmcHhNc1VNWnFkRWdT?=
 =?utf-8?B?bThGZlVUUzRJQmlLMVNzL1dqUUIwbnc9PQ==?=
X-Microsoft-Antispam-Message-Info: Q8wX4PLskrSqIvoe48jWcFIIoR/v1E70RAPoPOW43VBkwn5pDuWkpnt5vRLdOJvrTWoNLpeVe+cvn0XqznZNpdAok20UArqT7VYHWqNEe7+k+xJoMcRuTwZyy57nMJegP1hGQWuIeLg1oYITnoGeeYqUyVLGIp8eLq0IU0x643iWif2XvjFz7EXhNyd9DOp/WoKe3ZHVnvbZxyYmFCCX5gV+E/uijqm7TmF4wJ0o2uGmzo4wp/9gMszfb+ap+NuHHkCIBRGbfOIL//CFsfBVi8z/Qe+RXjr75iAMULiTSF6JTMgS8dYiCyzutZc9nnvAfzkDwmD2rvg41m+SyOHsbW7lHb37DbtRpLUOBU5I2aI=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;6:8RbQCAu5u2wNmw3k1rMyjFg0B+07DxGQGEej/VGYB2t1YlQ4L03aifTJPkYDXcr50BQdolKoP9zQtom7Wzv0ofgHShcSaeg8ntPZ7K/dxDc085PcZOBXPdjrmX9wl4QnaxGhkQD0F7U9sciTLusHusHvkgHJ11KuXE2JSPWFnwc+PqGLoM0Kbq1ro52t4Yf2zdMwloGX0jNe4rG6zuj6flSEvxGmN7pXsP4wrCyQKH+hdURbjXIOkmZ50mETUajaKvhBCSSmz8ZeuUG2IxiIJ3wxwN3oTQJeu67bl4bQL7lYPKSDg787JAlvA4mHBwGlTl/b4Ce0ztUxR7qOtaLSiAHtIbsuUTvYiO4SjuYaVgmO07L8RHhMUzD3fxDpb7w6Yzu35SX7y2aJaNmavXsrluJTaPnEAF213IMvhQtRjTTzcwvez1a3lAAiGVDcqXCvmyqIeb6m0GoNZPJ7A1bHvQ==;5:PZLKFG9vBFecTM3A7Gwimk/hPYYX6Ij0zGyfP+NP4pJ1A8JlW28BIporENKAc6d2LfyasuZzbyu3BlHKfaVrVSQQmRhQrMthUGl/YWrDFQD3zcnPutdV57Bm6DYQCtwqsUyikTDSnWv1CfR4xCeW9qNqY0fP1A2xwHjXia+KQeE=;24:KCxTEchjpFv2c4+vqFIku5AeSN3UOzMZyBX2Hheo5ld1z90dlKnAUFp3h2m0uG9IgsXEoiVsUm2P9Il0TzxesIohJ6UpYYwdVAJ6m0tZVbo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;7:HPjWdEWQN41RnZxCJ0UVcfoBcWp886c7Ask+Rv62DtQt4YaBs2JVs8WkF7W3/TcG8h8+PJii85d8bhVp2hDK1C63EzagCEZHc4z3zvIqp0MgFEUoQ8oP99hmdN6aMLU2Nr2mk3siDfeWZx2PpaOASmwQKYHLV+vSUvYRx5QiLDy5bsXvGoLF7H8sUffV//tgoijjxzrqFv+Ax5Cd0aK3/kiby9LwqCG5g4o2dtvzMwC0PM3Z6IexW8jKRiKclMFR;20:K1y7sisFXLcIEBVKMd7ia1e0EU3YkhpnqSjZw9YNEueaMAeznhGlWAwgcsP2DhVx05jtWxzpJkjY/tCSK+YaRdVtaC7B/gx7mFByGmRGGcsYzCOF8zH/0fz8cVIqeKHsiRUMQnQPCAFw+aOoqUx9zFX1VJ7VNddkiSN6PF/X0Mw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 13:20:28.8005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1541b8ff-6c23-4643-8339-08d5ebe81154
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2018 16:15, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    483d835c8189 Add linux-next specific files for 20180713

483d835c8189 contains register_shrinker() in sget_fc(). It's fixed by 72589a599d79
and 2c028928aa4c, which came in next-20180716.

> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=169b4770400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=60e5ac2478928314
> dashboard link: https://syzkaller.appspot.com/bug?extid=50d322b3e0b15a4a8d55
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10faa9a4400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f57794400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+50d322b3e0b15a4a8d55@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 4462 Comm: syz-executor763 Not tainted 4.18.0-rc4-next-20180713+ #7
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:list_lru_from_memcg_idx mm/list_lru.c:56 [inline]
> RIP: 0010:list_lru_count_one+0x156/0x460 mm/list_lru.c:201
> Code: 08 3c 03 0f 8e b5 02 00 00 4d 63 bd d8 0a 00 00 e8 7f 35 d2 ff 48 8d 7b 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d8 02 00 00 49 8d 46 c0 4c 8b 6b 50 48 ba 00 00
> RSP: 0018:ffff8801ac967198 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81aa3a64
> RDX: 000000000000000a RSI: ffffffff81aa3ad1 RDI: 0000000000000050
> RBP: ffff8801ac967228 R08: ffff8801af1c6300 R09: 0000000000000000
> R10: ffffed00359e0088 R11: ffff8801acf00447 R12: 1ffff1003592ce34
> R13: ffff8801ad6aa080 R14: ffff8801ac967200 R15: 0000000000000000
> FS:  000000000206b880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006ce080 CR3: 00000001ae3c1000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  list_lru_shrink_count include/linux/list_lru.h:122 [inline]
>  super_cache_count+0x153/0x2e0 fs/super.c:146
>  do_shrink_slab+0x148/0xc50 mm/vmscan.c:458
>  shrink_slab_memcg mm/vmscan.c:598 [inline]
>  shrink_slab+0x861/0xa60 mm/vmscan.c:671
>  shrink_node+0x429/0x16a0 mm/vmscan.c:2735
>  shrink_zones mm/vmscan.c:2964 [inline]
>  do_try_to_free_pages+0x3e7/0x1290 mm/vmscan.c:3026
>  try_to_free_mem_cgroup_pages+0x49d/0xc90 mm/vmscan.c:3324
>  reclaim_high.constprop.73+0x137/0x1e0 mm/memcontrol.c:2060
>  mem_cgroup_handle_over_high+0x8d/0x130 mm/memcontrol.c:2085
>  tracehook_notify_resume include/linux/tracehook.h:195 [inline]
>  exit_to_usermode_loop+0x287/0x380 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440ec7
> Code: 1f 40 00 b8 5a 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 6d 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 4d 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe197f4e98 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000440ec7
> RDX: 00007ffe197f4eb3 RSI: 00000000000001ff RDI: 00007ffe197f4eb0
> RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000003
> R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000001
> R13: 0000000000008fab R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 82052695a1b5b84c ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:list_lru_from_memcg_idx mm/list_lru.c:56 [inline]
> RIP: 0010:list_lru_count_one+0x156/0x460 mm/list_lru.c:201
> Code: 08 3c 03 0f 8e b5 02 00 00 4d 63 bd d8 0a 00 00 e8 7f 35 d2 ff 48 8d 7b 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d8 02 00 00 49 8d 46 c0 4c 8b 6b 50 48 ba 00 00
> RSP: 0018:ffff8801ac967198 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81aa3a64
> RDX: 000000000000000a RSI: ffffffff81aa3ad1 RDI: 0000000000000050
> RBP: ffff8801ac967228 R08: ffff8801af1c6300 R09: 0000000000000000
> R10: ffffed00359e0088 R11: ffff8801acf00447 R12: 1ffff1003592ce34
> R13: ffff8801ad6aa080 R14: ffff8801ac967200 R15: 0000000000000000
> FS:  000000000206b880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006ce080 CR3: 00000001ae3c1000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
