Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C8FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB4920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XNWpX8Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB4920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIGEvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:51:33 -0400
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:62183
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeIGEvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3CGfzG247cIvMHOTtFc3F0DDqtK0d/xDNhzHGqQxKw=;
 b=XNWpX8UpRRXbw9vnU/wEqJaako9TybyFTgs0jGoZC1wwXgj7OyltbtmMSkt7yrhCRD0Eg+njL8vybyEM6SjKDhouOWOD2zENPLb/4JtMqJK9Zxinxgdi0atXpJMd6lLWOUwfWD20QGZFoWANJboKMbWeQjUK+SSWHSsahCooP+c=
Received: from [10.236.18.153] (165.204.77.1) by
 CY4PR1201MB2532.namprd12.prod.outlook.com (2603:10b6:903:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Fri, 7 Sep
 2018 00:09:19 +0000
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To:     Christoph Hellwig <hch@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, jiandi.an@amd.com
References: <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
 <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
 <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
 <20180808232210-mutt-send-email-mst@kernel.org>
 <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
 <20180809054013.GA20507@infradead.org>
From:   Jiandi An <jiandi@amd.com>
Message-ID: <f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
Date:   Thu, 6 Sep 2018 19:09:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809054013.GA20507@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:404:f5::22) To CY4PR1201MB2532.namprd12.prod.outlook.com
 (2603:10b6:903:d8::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74142844-8783-4858-8990-08d6145629c9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB2532;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;3:OR9UBLXLmcDC384Upc05545rPLAL2HLJkDx8bDFMK7rUzBxjNx4jlTc/xLori1711+ZgaTqfEwsDq/8MiTxCFgphvb/XNTkwtIwxXeBvFxppYfM3CJfPGeHZSGgiTD08GaHTghvDrmOXcJnntt3wvMsoQvkTSUs4x0sRU0rjTMYm6zwBNTzynXbwQr+Idh6sZIR3nI+S+MKwQrXVos7fiQOLaTW/apoJzS7+JCMwMgtTD3LJev31PLCszUFmjUFA;25:ejJ7MpSrYAMF95H+zonoRn60XCAyUjXHddx1QVUMN0E5gGQj0NLpfxG0uIYvZdTIXRfjYFGK1/aTzmZBTMO7Immp7w6yukVi5Ya2vrrhAg3PqYTmSD42vhyL1VF7PxGr8JxV12YzdkDT5U6eN3iDp8MStogtRzVHCCa/kxqgDJYS27xXw76Afsvs/6PKRCbWW1aWHSR5QZMBanuLBbV4byTjG1o66QZx9YH0mPGfdkwBqHeMweUEqBOZTM5Hj2UD208rBTN/PajTJZuBrZFJzZ6Wj5EQantTu4fE7lyY9qFokTRFsHrbNZPPr2UBYBBPb7olbbImcWxg3d4MLKFIGQ==;31:yYkMhPtZrLJSeVpXvQeJemLMMjO4uL4jzTo9RwAIFqVlfRT+VRmTApmT4GpCOCw3022WZK7tG5bELTxwz/XbM7WTqm2UotvdGQ5Wm5AdVSKaFGhzK+u2RnP7JpLcXA+KUKnIGCN2MFKrvWappe6mzAiIX4Lb7LT0Qt2QKLz30I870GF+TC9HpnfLLueW5pfB8tkLax6ungeELdKHOc8N/hrk8qG2DTSNr6kpGPqqLiI=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2532:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;20:esd666f39e0eI5X+zaEcWoKqfbg+xPF+2hDawo5dB0NEgUpsMho7aqwvwPLD0Z/A8nAj/v3FxAFq8L4MPMtk2RhlCFN+jHAtDA7tI3oqAnLfW6qZmpluDBYvv/7+8ykNxowRASarrNg2mCEbdsxmKVQuS9d+6fRNS/UvxK352AW7fAr29jdTIVZtVNLaH6QvHTrkjZCQnSYU0dRbqu1A221/9Pvk+fKJ94xVSn3SsWMBk6FarbnOqjhhLBiwHnOtdEJuiZtNAcqZz/vmAzQbtsKvsijYIlqMwm8BUjf58TxmkGe5HsTzyUXPWx+jCqAnWIHRyPw131hluyN2/uYrC6EYiQVoZHoM4I5ZyNI5bGUCDo5TQROxPtA/aGXdV2IEeRWhKD6mA6S5cobLtI8tTmkNTgCN+hKqzaYVuTnoCBFOITFPIJcNDFzNs8rrSRBs3l3qwlH0R3WAW+kENkS4rpHeAk7vAT8Q61uLWMCTCQFP7PIf80edsg4HIIz0YhZM;4:ZKnOCsCCDnvxIKYV1EAklooGpE9A+AJnNYlSgwQMUI2Vf3z4fbxMLZhYee7S3QQySUPPfv6NiUqrQZR6YlMRI8CrthgCxCeOiRcu8vHqEIw1oDMj9JmK54Od8zz0yvcm1vpAFw9EkMWKWH6lCq76laa3xrht+GAsHvrZr6tJ5b0ZpblfKS2jqUGJupoqj3SonGSEgDz6Fifh2aJG8CV8c2HWQMJe5rgoU/sJM74ghSs+9jAm8qcMYp1aZtk7bS0pFPqUrPaMACwhM8Erfph4hjQSCNhfi2+X8uVNapNaY4l6ct/Td8rGBsSVoVUKcuPl
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25323F54BD6E2C25FD71B57FFD000@CY4PR1201MB2532.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231344)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY4PR1201MB2532;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB2532;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(69234005)(36756003)(2906002)(31696002)(316002)(4326008)(25786009)(7736002)(68736007)(64126003)(7416002)(93886005)(6666003)(305945005)(72206003)(5660300001)(65826007)(81166006)(81156014)(6116002)(3846002)(97736004)(50466002)(230700001)(8936002)(386003)(47776003)(31686004)(8676002)(53936002)(229853002)(66066001)(105586002)(106356001)(65806001)(65956001)(6486002)(14444005)(58126008)(476003)(2486003)(956004)(110136005)(52146003)(2616005)(6246003)(16576012)(23676004)(53546011)(446003)(26005)(76176011)(478600001)(54906003)(16526019)(11346002)(486006)(77096007)(52116002)(217873002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB2532;H:[10.236.18.153];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjI1MzI7MjM6WU92OENHQXBjQjhxTGZ6dU9qK1JEMjVn?=
 =?utf-8?B?OUVLV0djZFIxd0M5TlgyVkFEUk00c1lPOHVaZkhVVFFXTGYzWWs5YlBNWjlh?=
 =?utf-8?B?dzd6ZUZ2MitCL0FidEhseURLZittTmUvTmFUdWM3bEZqS2ZMY2VPRmxLLy9p?=
 =?utf-8?B?eG54d2xaMzV2d1JyKzdvYWlIWGREN1lsbXoxZzBkd3pHT0JlbDdSWE5OR2oz?=
 =?utf-8?B?QVgxVFlCTWxnNDU4clZHQ2dXOTkzVHdVY1BQeVA3RDRjVklSQmFZMWxzVjRL?=
 =?utf-8?B?YUt1Yklzb3lhMW96M25kRFBpWG94c0RFR21EVDRnQUZaYnI5eDZLWFlibnhv?=
 =?utf-8?B?eUdqUVFWeXRqQW9RT2VlV2hpUUpMUW43RnRncVNyV3YwSWJGSmJ5Q3BRR2dt?=
 =?utf-8?B?aXRZUVpCUVBOaUVhZFZaMWtZSy9kdGltNU0xNWZleitXYXZtTnV2cEltTFNl?=
 =?utf-8?B?MXlLNmNxSm14YkhjUnV4bE1WSk90dm40TENubFZFeW9tdzFuS01hNTB6bmVO?=
 =?utf-8?B?TUNqUnJLOTJkb3VuMEJJUTFWdUdqTFp6WEhTdUwxNStVUUkrV2dqSVZrbGo5?=
 =?utf-8?B?V3VzY25lSlZMck5KK0ZGMDViNHdZS2lUWUJZUm02YzlYdUJaWit6OGYybm00?=
 =?utf-8?B?YlRzY1lueEVXU1hjMURXNUVzNExUMFhVT2N6WXQvdW9nUm53eVhnMU9Jenk3?=
 =?utf-8?B?ck1qYnhNTGFWYlBSK09JUUhaOHpLYy8xMFdGdGVZWVZRMmR5ZHBOaDRtaGk0?=
 =?utf-8?B?RWFjUzZVby90alBFZkY4aCtNclllV2pQZjRwZ052TVgwSy8vUHFib3VKY2g1?=
 =?utf-8?B?Z3FiSkQ3MlFIVzFWUDVrMm52ejZQa2VudnpLdzJWV2UyRHh4QkRhOWx3c3A3?=
 =?utf-8?B?SGsvc1hYL2Q3eDJxc0d4cnVOR3hhRzlIMzNEWXhTbkFqSTUzYXBFU0owM2pm?=
 =?utf-8?B?SjQ4ZDZPUkpWdEVVaFFHM2paZHNxYUlwVDZaN2ZlZjZhK0R6MDZEVVl0ZERI?=
 =?utf-8?B?UWRKSTdacTVQWmxodjNxOXBCS1Fxck50OUVlTFBuMC9mMHhwN3IxeVJURklF?=
 =?utf-8?B?aXdUZHdHYVBjR1ovd01VMG1DQk4rMTNuTzY0YThENnc2TmZzOEtrMXRTZTRG?=
 =?utf-8?B?Y0c1NnVGWHBwMjJlMkZkME9BUzRCTVZTQm9OaS9sL3FnZzZRZG9HbmNnYWhF?=
 =?utf-8?B?b0N4NmZwWFRHTnlJQ0l4dkxudzBrUVJvanVHSzRidGFsdmF4cE1DNDFGVW43?=
 =?utf-8?B?MHZwUDFNZTQxSjhRa0dmVVd1aWdBOVVOcG12OUMyZ1oveSt4empDaXcwZ2to?=
 =?utf-8?B?NVRkREZmRkdWdm11aXpkajNJeWZYRHNaSTNoczd3MDBzNzdqeEVCdW5kVkVG?=
 =?utf-8?B?UjYra1hTbXhiTzgydjhiUWFrcGJsSng0RUMzK3g1bmtBVTFHMmRKb05OeGRs?=
 =?utf-8?B?alRIaExxM2hVOWFvV1hNUlVjNnNpM05FVk5zLzJxUmF2NVVidGkxWmpXc1BC?=
 =?utf-8?B?czNTZmhSZC9hcTFySjluR0ZpRHV1TFg0VWpnM3dRTWxJS2RnOUJHSHRRYXZh?=
 =?utf-8?B?Qy9keEFDS2RhRlprOXNCNDU5czlKamxOS1BGTTdyYStvcEJ3akg5RERkb3NB?=
 =?utf-8?B?dWdQOUFpNU11V2VGbnNLcUVoZXVTUktnRmhzR1lkdVFmUCtFaXlJSElGcHYr?=
 =?utf-8?B?cm0zZ1lDT0VEOFdMczlCYk15R3ZIZnU1c1JHdmZkQjllb3ozUjN5L095VXZj?=
 =?utf-8?B?cjVwM1RtVlZscEYyMGJMc3FpQXlzTVMrVkdYV1NRcDVhbmc5WU9zbUtWZ2lq?=
 =?utf-8?B?VjIwT1FkWFhZd3NpVXFZQ21GTnJ5bFlZbjVHU1NVK09WM3RIbVRmTVY3WGkr?=
 =?utf-8?B?Y05iUEJBK1FrSmFxVFRldnY4bWxEVXVEZlFTSHBWMlJVRFp4blhZenBPUWRD?=
 =?utf-8?B?NW41aHdoRzY2TnJTZzlwaFFoUG55Vy9GWHdZZ3RsbzlqbHhCWEZIeTBnRmJD?=
 =?utf-8?B?Um81ZVp3UllTRjJYclBqY1FqMnZZcHc0WE5HVERmQ1dwU2xnem84eWEyYlRq?=
 =?utf-8?Q?jdfvpA=3D?=
X-Microsoft-Antispam-Message-Info: qSiEM7wBR+hBhvmlrreb4eB/8itRuKh7nLu5mME4ByKMl07GFxzIf1gJma49JtBt+KZARjood5JMzL2+0R4qITg9/GWoi4qrBTjUbFp9HvedxDtvcc9JpmhfhnLZmchzavKlEV9Bq/zI1nsnv7JdyO5j4q/nXQXKJAc8dP+sVkYbVi1WezFCp0FOUN7Nt8wL2AxXwX1E2NJAWVafZRC9zqwdQ5/ffvQys6gBUNeTOeICXCiIU4ifAymZHKea++vEwZD5R2iCKURacNUQ9/rnlntmbQ4ojEw4ok/6qZwvLl2W7kqwCtTiZnnzqUJFduEcdaX8/Yp67gxvuLwfOBmoAUgeFyqQ8/Wi7W6oUjtYTdY=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;6:nhYZrWlIvLw3hQ85NS0ruZT9nCae8oHbf9wTOZzlkmG+Nav2MOskT8RVOn3Umi7v2ZpWmN6TCoNg3WjysJfZ0MYn+xF6OHR88GI/I/3L6607vyoxyark8hpsgamkhQOdS1/WtsCMFnVqWLoJCPIZAQzNfnNj7COsm4vKpidMFTfQjNTR24j7T8kSOqxFDp0z+GLqR89GNZp8qwUhpUAxJ0Eo9ESaK8QkapYZZKWTf0inM/8QtzBGhlz2b5FGbWhuHA6Q5uzPOi0xM8wKf1rsbjaCym0sl7ec2AMpbuXxPsb6mDfP/GdbdWS0g8pzML9EZgWe1t0YyV4AoLUL/lcjNSN3LgvhQQ2cC0JRTmcBVd9rtAQ+wvBi2+T0ZYlZZT1L/XJD3thXhMClX6BAoirb1kFAHjsfnWq7f6o0pPRvIogfLs4V548i5JvEWH8FRvkTUku3wCW0xf/AkDMAejY1AQ==;5:OCK7nm6p3+qds1iiMHf0wCUxGim+4l2emKLl51fPlajO6rh7J2b3jZaj0bWChTYgIPj0d9Qav7RP9h8FMru1ocuecsdalET3fBOyYdjBzmjrvfBGvPHF2Ss2twqw8GCdJNAMKkrTyJ4mEXjCoglrQPKublVb8zkyZ6Xgo1sM7RM=;7:In/zlrM9JikqUd6zz92fWWdp0o7lRBEYhNG3tOhizyv1OKw2mT1VweQy/efMMphs3VXdErmI+n2wAAahaYzf7AkKByb3J8Y4xVtpbt4bL0hvWoqpFGITPAMZA26H54B03MI9nlm/a2Qx0waOrplgLG5VtfZjW/ECGLMEiaSUpZc/d1mwFTtYmIz18feoX05gzHiw94e8gaS3oyBY9ptzbmESXItq6gIdcACQx12DB6Z95NIqY1bSBeLL3VrNrPgn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;20:WqyPFkg2H5dWyMOUF09sBFpnbhxXBKUqeC/rsB3sQm10O7b0gP+rw3HQbr4dCp05MIQ1rR+iQd3gvHolqq5XG1DqdcTvzbXppgBUIyD/X57ZpgRoIw9NC2uWZEv8bCXppnhD35yTBzoKVw68NZpbo0jfC7d9hm+fS70RQ1q7uNffLuiYP0Ca2cnyn6NkxpHqBzUJoy4teXCwsLF+e4EFU/N0uzD0OaGMo+gULrMwxkcX91VEwpeXZu65jfvDL0Yj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 00:09:19.2217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74142844-8783-4858-8990-08d6145629c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2018 12:40 AM, Christoph Hellwig wrote:
> On Thu, Aug 09, 2018 at 08:13:32AM +1000, Benjamin Herrenschmidt wrote:
>>>> -	if (xen_domain())
>>>> +	if (xen_domain() || pseries_secure_vm())
>>>> 		return true;
>>>
>>> I don't think it's pseries specific actually. E.g. I suspect AMD SEV
>>> might benefit from the same kind of hack.
>>
>> As long as they can provide the same guarantee that the DMA ops are
>> completely equivalent between virtio and other PCI devices, at least on
>> the same bus, ie, we don't have to go hack special DMA ops.
>>
>> I think the latter is really what Christoph wants to avoid for good
>> reasons.
> 
> Yes.  I also generally want to avoid too much arch specific magic.
> 
> FYI, I'm off to a week-long vacation today, don't expect quick replies.
> 
> 
> 

I've been following this RFC series as this has impact on AMD SEV.
Could you guys keep us in the loop on this (thomas.lendacky@amd.com,
brijesh.singh@amd.com, jiandi.an@amd.com are on cc).

AMD SEV today sets swiotlb_force to SWIOTLB_FORCE early on in
x86_64_start_kernel.  During start_kernel, mem_encrypt_init() sets
dma_ops to swiotlb_dma_ops if SEV is on as it uses SWIOTLB to bounce
buffer DMA operation and it's marked as decrypted.

For virtio device we have to pass in iommu_platform=true flag for
this to set the VIRTIO_F_IOMMU_PLATFORM flag. But for example
QEMU has the use of iommu_platform attribute disabled for virtio-gpu
device.  So would also like to move towards not having to specify
the VIRTIO_F_IOMMU_PLATFORM flag.

Anshuman's patch [RFC,2/4] virtio: Override device's DMA OPS with
virtio_direct_dma_ops selectively sets the default dma ops of
virtio device's parent pci to direct_dma_ops if VIRTIO_F_IOMMU_PLATFORM
is set.  And later platform specific code can override the dma ops again.

 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -174,6 +176,9 @@  int virtio_finalize_features(struct virtio_device *dev)
 	if (ret)
 		return ret;
 
+	if (virtio_has_iommu_quirk(dev))
+		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
+
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;

Would like to be in the loop and put in the platform specific code for
AMD SEV at the same time along with this.  Or does it make sense that if
swiotlb force is set don't override virtio device's parent dma_ops to
direct_dma_ops?  What if someone passes in swiotlb=force from kernel
boot command line parameter, this would override the parent pci device's
dma ops to direct_dma_ops.

So where is this RFC standing currently.  I saw Michael's comment mentioning
this RFC is blocked by its performance overhead for now for switching to
using DMA ops unconditionally.

-Jiandi

