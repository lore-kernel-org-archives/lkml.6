Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81A8C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B37021470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g1KuV9ID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B37021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390063AbeHGRx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:53:57 -0400
Received: from mail-eopbgr50090.outbound.protection.outlook.com ([40.107.5.90]:43008
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387578AbeHGRx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz2w5fJXdWqMn1oOXDA+rfsXW/U99Vf7ljx+Ic1im58=;
 b=g1KuV9IDx/Z8Q7e7z5x6BW558qmx4dGjg2apJXJkmqrQKp1Q4ncWfHUHuiOmf/48ejsmWh1/672OTERGcXviXkMxhtUXxnqkrcuIrnkqahbd47kN+uYZiSIrzLOfrDLXo/MdnGLtVgfu23/FALRxrMz1ePUCTGgfz1PEJXt0pTM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2032.eurprd08.prod.outlook.com (2603:10a6:800:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 15:38:55 +0000
Subject: [PATCH RFC 07/10] fs: Introduce struct
 super_operations::destroy_super() callback.
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, ktkhai@virtuozzo.com,
        sfr@canb.auug.org.au, vdavydov.dev@gmail.com, mhocko@suse.com,
        chris@chris-wilson.co.uk, penguin-kernel@I-love.SAKURA.ne.jp,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 07 Aug 2018 18:38:48 +0300
Message-ID: <153365632811.19074.14026254201855676335.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:50::27) To VI1PR0801MB2032.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fea4c23-9e09-4c58-c4eb-08d5fc7be4e8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2032;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;3:AyMVy+6dGfOLA+zlBNLanKxbZ6YX0DxTnIci3l3kNDxmn/Xlzv4/t0QHVW/Ycs28tpOgkgUyO2P2dkYqqa1wrpZnNlS3Ugw+DQHFXtXNJfhdXoznPQfd8w+ka8WoyvtnQpddTRgJ0qfMlJ7FjiV5SWXPK81Ec0tl7hf3TS1bllxCabNPu2kUb4eVlvrO+WPoYYnUpoIYKACH/Z+wX3RZUbVokj6SFnRr9qbYgAxuT2c/gNQ3nQD2mB6AOP8GRUd2;25:7i+mB3K3yz1iqaN8lOW278iliL/ObXg8y6eNeavKR4HFyIXoJRqhAWFRrXwQN4MNP/x+MALZC2aDZ6WNmGfI0nyKi6CDDF0TH0uvlpZeJndIHKThZBdi/YxBZijpCjwBtRd2QzTvY8urcOGisE/uGB5v3X5I0t4SoJKf8A1fqTW1kwoRDJnkshq05FpbxTfwyxJrA6VsHpXk6S5kH/p6XNIQh0gxqZCtHKSUXfbseKZAClpRWSUMsD5IWaT0xUu0ei6TJiyYmObSo+x7t+Iwks5KVtBW74dnOSXmVFlWxnxtTv0FGGITDSmfn9hdoEW1w0fBFkfsj3JyggjeM3Ptmw==;31:vj2N560yOsvJxJzKEeJg64YdRw2/B74IUx2T9eglukKW+I1OEmcp+LDKsa73iZxAoEIOXt0qMb5W6xtDSagpk5gwnGerJqDVAgfvGfj1vjb8R27XyGdejEeezoX6SdwSqaP8n7WgRH6lDCGKXMs/T/Pc92fXSq4g1lJvPHw/RLzjkDyO17mZ+dFls+wdgW6dZeW1QllbMbk3dFN0gscqdZyGjCf3gGj2sxtcjF44VLc=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2032:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;20:9rXmBI09PKWjgywaJNv8ft9Chyq/tJqvJLrzztOz566hQstUMpCL3FZHFvSY/cMflkhLN48Qk0GRCVuAF+RtsMMGa5mBoLPG8ppai4SOrvqniq03LwHL2VPn2Zvrr9/p8NfkB6coUN75pmdScGZFiNRxgW7wfQ4nJbYRprka4To6pvccZ4WWc3+QV7q/d/uokX20e5TQhZReSGF4wV18ZdcurEQMvZ7jK/PwVK25JirVbsEMLKH8jCFWvA2aWgSuRuDl2iBVyQM2YFhFDMeGv7lKPSS0xkSnarA8VfX5ZMadTtAYeezANB/vWhQhu5IXqbvfQo8oQRWegUSAWfy41hPTECNqwaZZ8xmzuse7n7rUwJ9ggUb3jC+KVrGAgmNnatAWCCEj7y4W4hwTndbA17Lku3+h1pXaLw0O+o3sh0FHxT44V+cnIw00YxN8QvU6crYol49RTRKbp8tAgnO/HhPqhyEI5hhrqiiReRxp3errQJ+z5SS8iXHy/qzLxsrQ;4:Pa7mqx1X6+Kd3v9Q7M4jl90VZ5yRr4XYUzn6pjLqgWiJbGtL62mbvVKenz0CIMebd/Ojr7eyklUfGJRQrfYlG1rd+5pixEXDqzYusfDrqpQdAMwDKdrMJb/qQg0FLDhc/Mc9SMoYL/UVe1jAaWNpwbLePeVBsifTKjtG5RrowRNyHX6AyPVsybIoWKVk88Ge+xJsgQSt7vK2p560jxCGRrsAVjKf/6mF5e0hBHQEVo+SKYxyO8hrpCmAhTUsxabWbNDMRJaBx9/cbctUi/HSjw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2032F32A4A92889008A6FE2ECD270@VI1PR0801MB2032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2032;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2032;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(396003)(376002)(136003)(39850400004)(199004)(189003)(106356001)(105586002)(217873002)(956004)(61506002)(66066001)(486006)(478600001)(11346002)(446003)(7416002)(39060400002)(7406005)(26005)(186003)(6666003)(86362001)(575784001)(97736004)(230700001)(476003)(5660300001)(16526019)(6116002)(3846002)(53936002)(103116003)(6506007)(68736007)(386003)(305945005)(7696005)(7736002)(76176011)(81156014)(8676002)(81166006)(2486003)(23676004)(9686003)(25786009)(55016002)(47776003)(8936002)(50466002)(316002)(33896004)(58126008)(2906002)(52116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2032;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzI7MjM6R25VZ0Q1a01EOTJISHBtcFg3ZjFUeE1L?=
 =?utf-8?B?WCtNOFFKYkN2cWpmb0NBU3hmMGlSSW1haFRUUDVKM2UxUTZYd3B4THNnU3RC?=
 =?utf-8?B?MkwxaFE0OE5rYk1Wa2NaamwvSEZWUmYyRDk1ZmcrUXA5QUF6aHZSd0lzWEZJ?=
 =?utf-8?B?THJSckYwemhtUDIvOTB4cmZGZmJQamIzQzJFQndaeWkzYkx1VTUzbUNUZWlX?=
 =?utf-8?B?UVVBcDJvNlJiS0JTYUNPNlZHek9tRTMzVFJkR2U2eTJJU2hyQXRvZHNST3pI?=
 =?utf-8?B?dFh5RTN3U1pHRGx6THRaRncxVkJNby8yZ1YvbWxUK2tkZU9RbXZoT0liZTNh?=
 =?utf-8?B?UlFkK1lXN3V0eWwyUzlNblQ1Y0hwaWdPQW1hd1NhNG1Jcnk4Rno4b3YxREdG?=
 =?utf-8?B?OWp0bkZBcFpOQm9IS1c0VmtBRGMrcng0VXVBekE4b0FZS2RrRWNJd25VYys0?=
 =?utf-8?B?MU5ObXFqT3U4MlpURGROZlBGZ3RUbjh6NDdHMzRoa1Z6ZUVQYUkwcng5TEY5?=
 =?utf-8?B?eDM3K1RFKzFIZUI0azZnOHFYN1Vodmh3WFE4d0ZHZ3dxNXJJc2NhUnVIbmFJ?=
 =?utf-8?B?bmM1QnFFME0vWWp2bjRkOTdiM1BZcU5nZkZxWmZKMGZ3ZVU4cFlhL2FJZHN2?=
 =?utf-8?B?SlpCOWRhelV0U3l4R1psWWVHbFhaeHM5WEVBaXlvRmpPZ2ZRelRvWUlLc0Fp?=
 =?utf-8?B?blMzSGxhaWlLTG5tYWl1OHp3WmtHWlROVTh0ZzJrdUE0SENUdEppU08xeHRr?=
 =?utf-8?B?OU1RSEZOR0xQS3VLM1M5Rk44Rm80M1lKNFp0REVBZ2R6dkFqZVJaYStDelFt?=
 =?utf-8?B?N1FmNUtXMTMvR1Y2aTA0TGJFTU9sRmgwUVJUTExlT3Q3aWh6U09TU2N5MUhq?=
 =?utf-8?B?R1k5aVQwWW9acGRGMmF1MzVLNkpqSjNSc1lUU2I5UzQrRGNSZC9jSkV2Zkgx?=
 =?utf-8?B?RHR4amNRWVJrTWlONTJCUnFXb0J1NHk2RzBqbjJFd3pySDRFMEdNY2p0MjBS?=
 =?utf-8?B?ekd2M3h4V3RDRHpJMnNQK0FYckxBMTA2T0lqRllQWmdPWFlvQzluWDZpaG0v?=
 =?utf-8?B?bHhIejVVMnlkZG1xd1NuczJCNi9OY2trR3IwUzA3SElOdXJqOXhHdDR0S2dI?=
 =?utf-8?B?TThtQzNnZWdIbnhRWU9QVWhsejFJZTB1Y1B2T0k1Z0pGd2tncWNSUDFPK3M4?=
 =?utf-8?B?MzZaNHF4RjY2SndGbmtrYnRmdlphYUlVOXBHR2ZSOWtoVXhrYjk3alREVk92?=
 =?utf-8?B?WWRPbEswVEJUYkI5N0xTYk9RUWo5V2szeld4QjluVVp5SUJhNUUwZXJxWXdw?=
 =?utf-8?B?dWJPWUNlK1RXTU1UMXpZUjFWWm9CMno1cTVoWm0vY0JLL3JJQTkzeThuQ2lN?=
 =?utf-8?B?RTBGd1cxc0kveWZkSDA3QlF6S2pCa3lBdHdhZENEeHRlVjdDTjRMdCtwTHZM?=
 =?utf-8?B?Zkduc1ZuK1NRSjZ5dGNkRjU4bEhUSnpnajRWa3dzRXQvQ0RtVlc0QzZuQit4?=
 =?utf-8?B?V2IwRTZ6TGVqeG9Oa0pDWU54RjBZd09KNGl0MTVTeWt0Y2l1anhlQlJQTkUy?=
 =?utf-8?B?Y2hJRTVjeGxyVVR4a1RkcTNWT2ViTy9lYmhMMmF0NE1wMTVWaXVpOGdnU2ZY?=
 =?utf-8?B?WHRXUDluQkFPVHIwRHNKdzVsYnp4R2g2RG5BNWR3bE9SUHVoK016OXBRckNo?=
 =?utf-8?B?NzlRRWh5Q3orNzl0RVJDMVBVYzZqMXhjNGNtRTkwWFRFcVdJT0U4TDZlRS9M?=
 =?utf-8?B?MlQ3dEcwaUpCZ2t0LzMvMGxpM2Z3WmZSQytBblBCQXUrLzVXTE80Tkl3enpQ?=
 =?utf-8?Q?+JBLCoQbEpbTYmT?=
X-Microsoft-Antispam-Message-Info: 557oruEBkuZ7QZxWw5rV81v99C2H7Vjp42DIc2/SbscZYCK4GxtLG1HW1fEG7Q0LzRH/M7ShHnorsiuztJKaSSnqC88+8QvmBlQsfI5pmBYBhMEFfoJCLVW18aIEP8u+sRDueAYWMH0fMD8rszZA4AxDKf89Gda1u7oiH8oVAa354pSdwk4cgs/MRwaNwIJflIRIQAE5HZrzRETwV2OHcCgdvxjTN0OhrkUTn/JIfjovnTab5Ub6P6d9t+nPcvewtbnkndK6JwIwGp9K7nWyefPY4KLrDd+HxbPgPhLqZPvBvfwplvKXh4hnOACPNyDqgQkoolHJ65ZZdDuml2HUVVZhUc6l0cknFOcHZAp9MvA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;6:NvFBujeBnLs3Le5Nc0n+VFlQ5XYCf44xixIZC86BrM1bCOmqNl9JpIwvdRCUFbGFJGxAx0AKlYbNU10S0FKFjo4BBSMYul1NbpE5l7kKGx0qVTWupYmB18gUIGVWsEKsMlKkc+KTZX6C7YB2dBvsCXw4nS3eSyPqZ9XH1D3GrGgdbalhqN08Mqr1El8DNL9KMbzra2zPusXSMFcbHayXMfYRUaGLNtGZWP11bAr7fLuQ/XBEnqA+jF/qgIWsK3nMKQDDHLBisBl4de9s/qq2XM6m+VENOZqg9/41y6NezBopMG4RXBGfTdvRzKod66PQ8M9YDFv/R2nRFo2yZBVczAOAvs5SMwjAJBgNnpzkQhDx+JgByQmuOsAtyGVTXAFPu9lKS0HIFn9WPXVuzoBs344jv5a9fiGP/9MreiK1clGSaAcJQ2eNQftohc+tIMePorvhVp/TozdTp1OqFksqDg==;5:h8XaS7IoNmTQJsHQYEFSt826TE5ctqmFbkwixP76qkOvgvBGp5D/TvpeWWoxODJYPUcCPSyGbcHDZYKgzuWPQqfN9iSLa9usFV7GDG4xlkklLzoOV8eOCVtfvzWvoCgfrXpt4t7+36nNEU2gfBcsRkO4UBmwZEjITI4nRMbVhLY=;7:wOGYVhyOpN/64bRXDkgPFn1honJYNFjp8kyoRPncZaeesY+WERxlUfHOzNgNfdBF2ZfKZzPayCy29mlEYBeW5XkdLuxX1Khwt9JPyzf7mBKL6AV7hZKbMWg7F2RSaIgA2+ZRyBIL44QNYkWLdftrImiLZl90OvX3paV/oPvyGN+U42L/g6r2b0uROo1bSPrb5lUPBNWI2zkCBNP9f4i5NHVERBT80+yJgiokl7hImF5jihaE9goG/vSdqmHuOAFO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;20:LqLirqxTPbI5EkhYC25qng7zxJqHDgngQ35x/ExQi88oH59ErfsezBZeYyHW7VLFPpsC0ST1qfuzJ/O5r1RYenqQV6byLdI1Oyvp3ETQms07mD5YSiOzkr0mk2U0G2n6vqeg9dO1TyKgRCHzbBaYkA2MwkNrJ+iVxTZVYskuHN8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:38:55.8789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fea4c23-9e09-4c58-c4eb-08d5fc7be4e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces a new callback, which will be called
asynchronous from delayed work.

This will allows to make ::nr_cached_objects() safe
to be called on destroying superblock in next patches,
and to split unregister_shrinker() into two primitives.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c         |    3 +++
 include/linux/fs.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 9222cfc196bf..c60f092538c7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -170,6 +170,9 @@ static void destroy_super_work(struct work_struct *work)
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
 
+	if (s->s_op->destroy_super)
+		s->s_op->destroy_super(s);
+
 	for (i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 842fde0f0981..33dfaed0a01a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1880,6 +1880,7 @@ struct super_operations {
 	int (*drop_inode) (struct inode *);
 	void (*evict_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
+	void (*destroy_super) (struct super_block *);
 	int (*sync_fs)(struct super_block *sb, int wait);
 	int (*freeze_super) (struct super_block *);
 	int (*freeze_fs) (struct super_block *);

