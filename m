Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275E6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A12083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="rgrCED+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32A12083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966202AbeFSKpR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:45:17 -0400
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:63036
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965682AbeFSKpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MYEpsnY2uUUHrRaLAd/GYHb9FV7QM+laqrB+MCPJVo=;
 b=rgrCED+QMfqChZXT8tWxHZ/scDzVxiLs5WTZ3wZe2xMQNujAI2CpZHdXXoFGRlC13Xpm13WVls1BM54B9n4+3Jct4/jBYBidmBYm18/kE01JqhHRD1ZaYSqy+FYVcJVSSubv92V98nQbdtIIuN3cYgLzPmR5bDPOdSGuWplHsww=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 SN6PR05MB4590.namprd05.prod.outlook.com (2603:10b6:805:38::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.16; Tue, 19 Jun 2018 10:44:58 +0000
Subject: Re: [PATCH 1/3] locking: WW mutex cleanup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
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
References: <20180619082445.11062-1-thellstrom@vmware.com>
 <20180619082445.11062-2-thellstrom@vmware.com>
 <20180619094409.GK2458@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <8ea67e74-5ed4-2157-8e51-43f15047b3e4@vmware.com>
Date:   Tue, 19 Jun 2018 12:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619094409.GK2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To SN6PR05MB4590.namprd05.prod.outlook.com
 (2603:10b6:805:38::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbabb584-5392-4f47-95ac-08d5d5d1b6e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4590;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4590;3:nT4kVQAEpKeItKrUzCbdXUk+kumzLhorJPu6q2c1T9q0D5BYb0fFBoZIdpQOqNcF7Kn/JSsZEQED8i+Co3XMrJvHXSniZ65LHdjQxy6LHlDLBL+9eaedb0y9L3hl7kharmvfvUg+qsfQlCZyeOzXy/cl7eZ2R5OpRYcA21Xt4P6mHBccUhIc1s0KabH8SxM3QN8s/tI4MbqnRO20RtbnPzsxh2Nvhjzmj2PIFNhVQtJPwG/3XGURCEpWKjtnRuWP;25:3M7MPuMLBJd5+3x3mol5unR02CVZHnCqoiD5xzbaM5JHOpYcTyYAj1uJOp3EtMHfrU8cRdH+nxrL3YFt3dbPj+dZ8mT/us/+oU5qPq8czHDXaK2TGg2gN/q0PSCGz5Mqg883Aoq/fkuo0KBsq2O9GUZKUpRSG6XOc98+7V7XkRP6AG4hUCXEW0IbSgZ0+31QZEdEmzDhqoCvwFP+QhwJLPGhSNjNZjS5y++6pieh77ZtOSv/OHex0q0yvGhzAg+Zg9LiZF1z1nukcdsn6sZw6Iv80HgKKWNVOEfSXMA2Z081chEGEkoN9nWD93os7Y4CqLMNQLV+6CNkGtpgpOsZmA==;31:BgkwciUl29Xgg6ihJrXKXa2qPWKyzdUPO+BfM97okQJgggOPBLvEAlvtT+RC6h6BtqUgFdgFQFnT7TBCahEjvm3ALWhFD7WThS0y8SfROr6qFgt4Mvo03nnxJ1r1IN55EFjCqgmZDCquEXQQ5wq2RyfpmPYvLzaS5pLAt5JXsgxhWxm0EIeObod2qnhHvPaj+vJhPhkquDsr1qv918CPI5gsDf0mzKrlFCI6WEgEam0=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4590:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4590;20:cA9z/DPvbIQnOCOCQUYasogfA/ltYeeI6n2Wcdt5JLQ23ox/s2bgA3J5gSW66XrmfP2ZnbFkJEy2CH4LfARU/8Qhvrbe9LuYJ2LPgIOG3lIQewQIjrHTEaoNhks2Sugn3MXRGfKydb28TPDst63WkEtRihF985x4nU1uOl1yK0PB73AZYR7Qd/yexbezTOk7Fo3T73LZl6FTDj64KFuzzH4qOA6MHosMw8DCkVpKNBHeBzvKqqFVQAvwRU3Wi8SEZVcCV+9rEqI//syqNl39topOQb/9IxaGtZqZzxGAp+OaA6xv/+WjRpTLvZDE+GA8S5hSgTnjlxII9kpOv3d461L1mb6NB4roNeQDEr7RmFa2k16XdtL2cYA5/WoLe9NKDy26NMYJ+F2wjXDIZEwiALkeId7Y5BHT88FlDtGz6PWefOHnOR0ZSkMelzHavW1L8g5rMQhW7R5CGipbVgExsmwAvBgBSTo62Y8iqWAEu8Sc9glsA4ssgK3t2DuZa4hu
X-Microsoft-Antispam-PRVS: <SN6PR05MB4590EADCB64DADB2B1250E8BA1700@SN6PR05MB4590.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(9452136761055)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4590;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4590;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4590;4:Y4EnXgY7XX9F/MQN+CGSpROgMkOTEo0O0K+xCJhB7bkpr8QGdlR3DNjuta6nUhaQgnzwGV1h8T/5Xj+tgqDIYUm4b6bPic169ExKBMVyyOCOe7ipzzeLh54KKf6ZU14mX6dRvo9oHyV4n+R/5vMjM3DqJIq9wywHscQC4zrtYnCUnx7WyOk9xoRns7B7CvGIIM5KVc7mfir7NiE5sJIDTd0b3Tez2WopDCm2P1Hqj3p7WXm+tWkSmyZdeMqzmR2SQ8IAQkzTZDMF/y/ozVHOQm7fX5M3F2mHqyo0WNoTrSdXN32bOJLK7F3gjvSrGsfYslbf5H/ha/9qR+pYZZyL5KQA1C2UjEuSXAWJEEg2mFbm5Yt5aTj9EO0TkKFlMsUj7ZE2om/MWBIQ3ba94Bc2l0qsCv0F0Fqb3ZMKMYz47aWUr+1ddQTLUyWQvWaVIizI
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(39860400002)(346002)(39380400002)(396003)(199004)(189003)(53936002)(4326008)(52116002)(476003)(11346002)(229853002)(97736004)(58126008)(316002)(486006)(67846002)(2616005)(956004)(446003)(50466002)(68736007)(36756003)(2906002)(54906003)(76176011)(6246003)(25786009)(105586002)(386003)(65956001)(65806001)(23676004)(16526019)(66066001)(186003)(8936002)(81156014)(81166006)(53546011)(305945005)(6116002)(7736002)(52146003)(8676002)(6506007)(26005)(3846002)(64126003)(6916009)(65826007)(5660300001)(6512007)(31696002)(6666003)(230700001)(2486003)(6486002)(478600001)(47776003)(7416002)(86362001)(31686004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4590;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA1TUI0NTkwOzIzOm0rak9iaE5vcW92NHhGaWFJakRNdTBXRVcw?=
 =?utf-8?B?WEFTQW00Ui9TSHVHY095aVN1QnJHUVlraVhaRHY0dE11ZDNxTXBhZTRHVUYy?=
 =?utf-8?B?clB6eVcvMnF3R2FvaEJaQjZGcFZDMVZidTNEU3Rmb29zSmZ2cDFEdURMK0xj?=
 =?utf-8?B?MU4xN1MwVElGU3BRY2FLSDhkU09ZcWlqR1laSEVxRDdCVXpja042NUlzRkc3?=
 =?utf-8?B?RjMrQ3JkUlZlUlpnbExiWmxGWEcyTGhtcHdxbkd6WVN6cTdvYVNCMElINjAr?=
 =?utf-8?B?TzJDbUhoUmtGWG5PWWtHVDFFRnoyVTZtVUxZNmQvaVd1THRrdXAwc0JtcE1T?=
 =?utf-8?B?TWtneXA2S3hZMmZzWTBndjMrZFpsaXlWbkdkU3R6VG02TldrTDZBYmpHalEx?=
 =?utf-8?B?ZEd4NDVZQXF5UHd4YjJ5SkhHVmdkYTdFWElsS3ZVRjY5azlGMW9SNVhVTnl4?=
 =?utf-8?B?YWZweWhXb1Y5NTBFMnNVQ0FNUTgyZUZaWEVjZE9iSDI5cWI2d0wySWRDYWcz?=
 =?utf-8?B?Ym85SG5TbUEvMktkZnJkci95VUd0VEJOUENhbldFOTJpaEhLTkZiL3UzbmVS?=
 =?utf-8?B?NmUyZithcnRBQ2ovaUhtMW1YR2NEM0hCTjZXU3Y4NTVYc3hGeUpYSEdFb3B5?=
 =?utf-8?B?QzBxZXdxcFZSKzZycSszbFFLdlZqOUVXOWdiQ0h4ZkYwdFRYZmFYUEhTalQy?=
 =?utf-8?B?QjNZZWk2TkNWS0hHelNkenJwM1dEZVZmdTErNU1QRXRaWEdReDFQSlNteFZw?=
 =?utf-8?B?Tk1KOExEbEFnTEllS3NVcGxLMUk5SDVmRkV3dlRpcFRZUlBKUmNvUnYvMDBa?=
 =?utf-8?B?V3lwZ0l0aElWdUx0V2RPNDRBVEhPeEZEZWtHTmF1WFc2ajhpSzYwdkh1VWxq?=
 =?utf-8?B?eEptZWgyQzhKalUyWjRYYmJ6Nnl3SXNIVUxIYUF6dTZXQk1Ub1M3am9lMUpQ?=
 =?utf-8?B?K3VSOWxMY2taZG9UUDRwYWJ0QStSS2FUN1lSNXc3QnNZNUdBUW1jZWhSbVdO?=
 =?utf-8?B?U0hCc3ZzZXRucHF5T3pSR1BkaEM0YkJobmVWOWtpL09rT3B1MDlyNzZqNncz?=
 =?utf-8?B?T3U0Vmw3dFFNT0s5SFhnTlh3aUpZdUhlVUVHSFNTeHVidlVHOXBBNUM5R256?=
 =?utf-8?B?QUdsbXFTNXpSb0pMcVdISkpVUWxRRmNjQ1ZSVlRuYWIvaXhwc3c2UUZrdFpY?=
 =?utf-8?B?UnFoNkVoWFhFeExtd1Vrd3FnTUFXYVM4V0ZUdXNtZGJMWjVCRkYvRzlJalUx?=
 =?utf-8?B?RmJvRVdxK1ZXMzBuL1pBVDFOUnpJMzBiTlpUY3Jwc3JmWVo5OUhGaG1xc25O?=
 =?utf-8?B?R3RXaFhCWDVVMHFZbSswNGRuRytpZlJFc0xFb3o2MlFqcmo2dkhjRS9PaXF4?=
 =?utf-8?B?Z0RVeDVLTGFtUGFKYmV3RDdUclVVUlJ6U0xRczJvcUo2dnNRbWVlSmJORFd4?=
 =?utf-8?B?VzVhVUJuQ0dHMzZ2OGtNSGZFVThRT1ZzUEk5enpBSnk5UmJRckhIaGY4Z3Zy?=
 =?utf-8?B?Y3BjV0VIRGM2R2JjMmdiRFlqRnBQZzFFN1BmZzV2QXhKbEs0UUVvTTNOeE5I?=
 =?utf-8?B?VHVMckxwaGtwbnc4WkZQQlpUekRwUmpOWDBTMjc0RHN1d2Y0L3dnRnFvUFBz?=
 =?utf-8?B?ZjdlVDlWVVpTZEZmV1VKN1MwdUNTT2JGNk9nMFVOSEY1OFlXNDBINWpBdWRO?=
 =?utf-8?B?OE8ya25FdkJvTDg1Wms2SUZNZzZKMmVYNUZFNFc1Z0xjZGtwU2h0QnR2ZXYv?=
 =?utf-8?B?bk9UczFDdGpYZzlaazgzTmtvYW1jUEQ4SEdlSmk2VG1VVjh1S0VLWnRSTUZQ?=
 =?utf-8?B?K05zeXZjK1hmN2hKa3c4ak9XMVlCZEdzbWs1WFEzL2NkNUlTN1NXNm9QVDdz?=
 =?utf-8?B?bkVMOU0wcjRjN0tpOHgwY0lhRVdpbDN0MHdXM3FqZVNKZ0NYUEl0MDlQV2FB?=
 =?utf-8?B?RW9zb1N4MXhXZzdWT0pQMkVIWU50WllGelJFdG5tek0yb0J5TVE3dXhQWjB4?=
 =?utf-8?Q?nem3oO?=
X-Microsoft-Antispam-Message-Info: KH7/F06bqkF/DHC5BDi+MwYC2goExhy8CfQ/O9H5Nwhn+YeTXM3yFhvUr1bKwr6YR5p3t/ORWCn+lxEBqt0g5zX5VdBbK8w2WZhIKvS7ojOqASpQkDz9+oBdguhXnsfZ7dhYsu1K9LXgc4CXqHxGigd8rnOunNeF0kpEs6dEFHlercstbbXRDw2oB2B8QHgzjZrLz9WYtFP+Di1Fjjcs3rj9O7lH3WIS5TlAWq5O+zBBBnNjQgLHmYfhvPz2XOQDWO4fmFxRoqnXiH2c1LXSslo4b6uQ5PfmuulRvJXkmEP/Azr7qThs2RBnqzOm7hFi
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4590;6:7hYVjet8DcAvWVO5+21fwehqhoMoTMwJl/JB2ZS9RKpgrW1E8QlGJWxdZYykhuhdbtoTFegFziJdzPKL8jsReWaQcqYpv5MothuHKVZWE7ENZa2GTQngLY0ODcPVYUJ+mBj4frYuhJAN/g7DW00akSx/CI3ghEZFHAmBRX7OICnFb91Oq9bsXQ2upOMx/6Dl19rLhN5VnKDdESnANhGmyFMLICQ1VlWm4lN81QaEGi0jXWyIyS0Tx7ikEnCnhJAZFOGUTdVwJp+7ay+m7ZH1Qs9iOh/sMHvr88lQaFUfe9vzCqpEK9mxY8fV3egRTOC1/Jw0Ck7Pg2RqPyDDUVhzlPq88DAzNhUvCZ4lAoM+Q0JNvGSB7+PpIHJXioTG7xLRScz1XqJCyCrOlz/RC5MgCL2W4Fcm+sfx19qEXarA9P1aVyp8BKGjudbGiavpxVuiWwvAXUeNZaVZXFbYC+hTUA==;5:kebNHlJad2KKAFP9vsoR6ASJXa1KstfIuZH7YvZT0VX2y9wYmPmreARf0fRWo1sS3bF2DOrtXAQLxd63uso42vogunOsnMwdcx3tRXayT9XqDHbKbEw0Fam/+MmI9JITAFpEZZlcA/FJAw24gPLq9UVJLzPRRgoYNNtF40fZNfw=;24:GGM3B1ExGObehhm9NMFLgm3dQOGeiA4jFVl/dUWBYJ5mcjbJGSxGGVd8b87fpyIAwkco/522QLA8n30GlASaq/4gjsgaTSyEUoA+4EfyJ1U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4590;7:9u0pUY4v3yU8ybQ7Quf8aVjUOmOw6VgGOk6Xn4giZd/kOn1bj1ysQWFSb7zmR02psWk7hTgkRThPs9RhTi8eLN1kxQCL/rLY+TPMTZ9HYj5kpdQqy7P2Qbxei22PcD6gfgY53BaXMGCjsSIozoM71DVMp/n7d58+l6O7gJsz31jGgjS55M3SNPj/eEl9NhP3TrYZ5cF0Z/bop/0uwjAueL9v8n9pFF9MLg0pPoxoEJmSELTSmlJY+57eUmHpDY0e;20:aXzwplRnyqiGCaf5guuWZUHbE+Awt6C8QCcotJXnNuoYhqS4GdxWycZqSfmWLIiag86izoB761AU23guBljDPSvR20LT9LVC3LwrkFsi4gwCuUUw7/cZ2Uu5cEJods+TZ0Agp30Fv40eidAex2sWnAjqv68oLa2FU+j0217WGeI=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 10:44:58.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbabb584-5392-4f47-95ac-08d5d5d1b6e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4590
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 11:44 AM, Peter Zijlstra wrote:
> On Tue, Jun 19, 2018 at 10:24:43AM +0200, Thomas Hellstrom wrote:
>> From: Peter Ziljstra <peterz@infradead.org>
>>
>> Make the WW mutex code more readable by adding comments, splitting up
>> functions and pointing out that we're actually using the Wait-Die
>> algorithm.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Gustavo Padovan <gustavo@padovan.org>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> Cc: Philippe Ombredanne <pombredanne@nexb.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-media@vger.kernel.org
>> Cc: linaro-mm-sig@lists.linaro.org
>> Co-authored-by: Thomas Hellstrom <thellstrom@vmware.com>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> ---
>>   Documentation/locking/ww-mutex-design.txt |  12 +-
>>   include/linux/ww_mutex.h                  |  28 ++---
>>   kernel/locking/mutex.c                    | 202 ++++++++++++++++++------------
>>   3 files changed, 145 insertions(+), 97 deletions(-)
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Hi Peter,

Do you want to add a SOB, since you're the main author?

Thomas



