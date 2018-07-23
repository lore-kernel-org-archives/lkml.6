Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27541ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2DE20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="cnXHEH5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2DE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbeGWQxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:53:17 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:46495
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387968AbeGWQxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/+YkBIFqgm17B6seWAJvQXYqaJl5XaARdyHaH9Baog=;
 b=cnXHEH5cofvS5zKTqGzfpyEwMIbwZawTRO7D6mF/9ynWjhWlco1b2OGbDbCZ+gQg9WJlIOkyQ46dzVwpm6aiFOYEo/SiaNEh8e5fjDzy0BCU/w46OBw6yLRY+HTDUHUuncGB/SDnNSAo9Z/GVIi8N+RqXUwLR7k9rh+bXGg9Gn4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [192.168.1.122] (46.211.25.138) by
 AM0PR0302MB3202.eurprd03.prod.outlook.com (2603:10a6:208:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Mon, 23 Jul
 2018 15:51:06 +0000
Subject: Re: [PATCH v5 0/8] xen: dma-buf support for grant device
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180720090150.24560-1-andr2000@gmail.com>
 <019c0eb6-8185-d888-ae6f-305ea2d44124@oracle.com>
 <df3e8c07-c8b4-cb12-32ad-119498be114b@epam.com>
 <80a074ac-91db-82db-d094-660d859cf903@epam.com>
 <9d2889f6-32d3-03d7-2a6d-341e691287b3@oracle.com>
From:   Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Message-ID: <5fc34b4b-3587-791a-d17c-7da955b393bd@epam.com>
Date:   Mon, 23 Jul 2018 18:50:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9d2889f6-32d3-03d7-2a6d-341e691287b3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [46.211.25.138]
X-ClientProxiedBy: VI1PR0501CA0031.eurprd05.prod.outlook.com
 (2603:10a6:800:60::17) To AM0PR0302MB3202.eurprd03.prod.outlook.com
 (2603:10a6:208:9::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a41a04d8-49dc-4aa3-e75a-08d5f0b42320
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3202;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3202;3:8IpbSqYZ6XM0mNBvmGMTF7d0oOU1Y1bG672XeGCltUqPFMpVMyJSmkabWoquSSWV2kWXvT4fpYemzCrZeTbwgCCM58CM9pFahx/A8w/tacLq3tOzsDDr6UUat9RP59n2hhsTaNI2DrkvrAPTvXwm3rbzXVvSOM/CpB4/eUk+u661djdUceTjqxP96d7xA4JyxhD2ipKSkEN2k+h6oDsU5AdeY/kQ4OEG0E2Zs2nYQWnAT/K5CgS04U3Fw/aiTyXy;25:pzc+o4+rj5hofwGE1iS3nVnEm2J7HDDHyrJKVEmfaqTxOBENWVlscqhibi3hjGrveIxMX7wQGrOPVQJyWmhMVM29JG+wap+yw4aUwgynb00JhAdR+65kTXPpEQc1DcxTXE0qkhqF3pED/nZW5V3f9CjktfaQB60HIMZLfz/FIKU/oJzOHTkuASVmbErNg37S0LWjuar/I2mBpOtBKx2OVO5wvQ2VU2oHLOlO0Ig0qqTWd0q2egahFo9xHPauS2oA3HkECM2w3pOk7W3WmNO9ilxnBXW1le3m6sCigByCooX1n2/tiwpnEwNujBwythLBRKCT2KzB2hgSWcFs8nrlqw==;31:kmBd/PhasfP7ouUJAVU3AGpm8/2mb2frGvPdm3DOM4W3h6yLTR+zEawi5kPtuUgYezDOf14u+gdzs+zjeLwILQw+qxEsWs/w+L4fyMir6PwqVWLmPMQS+RJHBzw8gC+j5Puxw4kMQyIym89cyWCFho0oLkpp/WEdwiTu5xj6teWo9iXTqiQVo1yv/GHPRvR5pCFQ7Ib/dWc4QdNKEY3O1/YIGVlvtw2o8fBDH5JTFrQ=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3202:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3202;20:PgngyuXtKWVkugohnVKL9jxpUJIEahFRa3l8YyQ5jex7rDYThyt2SBGeDT2p97Eoyjc+cfBzm8Ae95whQmyhyLFZrYI6cVDRRtaPj+GBouVG0w835hyN95hLJzNVRR8VN58FA8GZ9DUaNnKJjSiPeJl/lMqLtUy9CvVeCQvHzi5mD9OChoEF9ysl4bTT6FQLtTxPWdY2l82ruWE2RXYHgKQlee7w+a/OnAnfIlMKsiKRgOb9ytQrMgSDhozzFSoUeU43Bw2sCTMv1HMLGXfDlhSU/H13XUlYaC8SZ5UhzEzagQhcXPUXA30OATtp623sOVlvBHK/Fxt5/sdFy7Ufn/Xpu8kFHeaq5NFAKOv+RKgcwJaLojrXv7NvQEuPhaFbtXNyKMFEUOUHd+7GJCIWOFhqy796r/zL7nfeVu+OcvLDSF7Aax2557FSI4XrCTzQOCA1q6+wHqU9khJYlrxw+Q/I34X0y+a3Eb6TlPjGkRz/KrWu2wktVHbdAupAbwgn;4:ppMD+rvfQCsjj55tH8UqhrLpWunCZSyDIBN8KD20wTtWHWFDWx1mGBreGrwC3R6vjSleh3zDcZg84Hz6YPVgJ4qG2zVpb3vlmsbWDmXFtpG7+ljhDkRSipjQFatYdRLf9mGzT9tpubviqff0gT+DIt3hcyE5DYSqRR1hC2wET7aFZqBvMLhUXXIXqZjL+AOmVQMHjWupE43l0EY8EmfWRmNn8t9GfBK467wvRJ6MsVGYn8OkOYmCdUifYkw2SX1CUZ9UvSDvLBT3RvLI+BW+Zg==
X-Microsoft-Antispam-PRVS: <AM0PR0302MB3202578B73161AF5CA557FECE7560@AM0PR0302MB3202.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3202;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3202;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(50466002)(4326008)(80792005)(68736007)(106356001)(16576012)(97736004)(6666003)(476003)(316002)(26005)(105586002)(58126008)(186003)(25786009)(110136005)(2616005)(81156014)(77096007)(53936002)(47776003)(55236004)(2906002)(53546011)(386003)(52146003)(76176011)(2486003)(93886005)(23676004)(6246003)(16526019)(956004)(11346002)(7736002)(31686004)(478600001)(72206003)(446003)(64126003)(65826007)(2870700001)(486006)(65956001)(8676002)(65806001)(67846002)(39060400002)(66066001)(229853002)(36756003)(7416002)(6486002)(6116002)(117156002)(14444005)(3846002)(305945005)(86362001)(52116002)(31696002)(5660300001)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3202;H:[192.168.1.122];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDI7MjM6aWI4K1lYaFVid2FORFVDbGVXSXlRY0ds?=
 =?utf-8?B?S1krMmJSN2VLTlg3TFBYZi84N01XSm8yREZhM0NaYkV0QThXYTc0V1MveG9y?=
 =?utf-8?B?M1M5RTZzLzFGbWR5eUNyL3d4QnBTMjI3VkNPUUNaMmh4WUhXeU9MWUd2N0FO?=
 =?utf-8?B?c09mV0lIWmJHLytxRUdmTFhNaTBCYk9JMHRERTFYR1BaenlUWVRLNEpOREk1?=
 =?utf-8?B?SC90TTVHRmVvQThPQ29SamhhbDAwekIvS0VWNnZQcExlamh0T0p3RlFTbk1G?=
 =?utf-8?B?ekhza202QkZxU2dRN1JudHFJVTBTSG5UMlpGcFZFU0poNndKUU9QZTkzTU52?=
 =?utf-8?B?NHBmZWNTWm1qaU04VkpWdGpaanhMRVVzZVBnb2hVYmluUUhScFM0MVJZcnhM?=
 =?utf-8?B?QjBkNi84V1V5N1VMYjZJQVYvOUNSYm5jWit0T1Njak1KSXpPUEFJQVBEWkcy?=
 =?utf-8?B?T1VJZHQ2RnFVNyt0cUhwN3YvYmhtMjBZWmhLTFpVMWMvTWZRcGh3aWlVMk9K?=
 =?utf-8?B?U1hGWDRYMVZYcXd2Uk9lZXpHSnEzbndJL0VzZ29PYUh3QTRpTUNESHBDbFVz?=
 =?utf-8?B?dlNCREhKaEZLVXgweGtMYlRTU2dkTGk4UW9lV0JsVEhnSUdwdFdGcC9zeGh4?=
 =?utf-8?B?VHhaUGt2MzBKenQxMklmYXh6NnBFSlA5V3VpS3pSbHIrU2FVeTBJc3p0U2Rt?=
 =?utf-8?B?UHFRR2h5N2tROXNkdFUzQzNUaXRUN1ZIQnQzeXl6UlUvbWU2Ujh1bEJRVlJr?=
 =?utf-8?B?RGRMcUk4S0JaaUZDR3liakdnbXlsOTNCdXZsZmZZRHVoUmZiWEJZL2tnemdM?=
 =?utf-8?B?UUMvZ2JnVXYvVDBXVmRZVG1GYUlPbjFKL2x6bDhBbGErdk9vd0IwMittczIz?=
 =?utf-8?B?azArSEVqT3lYbTY2S1lHMEhyVUpYcThJNlExbnBld2p0aUVpZXI4WTYyenRt?=
 =?utf-8?B?UjA1aTlyWk9STzdESnl6akdDTUp3akFudlkwSGpHb2hBaW5Xa0dlZExXa01Q?=
 =?utf-8?B?cVcwUlU0dWY0TWhyOGJ4dURzMjFJZ2wrSW0xemc4S3FPQVVPNGhGOEcvazRV?=
 =?utf-8?B?QTlQQmZUUjJEZDBMQ2xuQUs1a3VLL0JwS0k1dnFTU0h3NGhhYmJYSHF3Z24x?=
 =?utf-8?B?Q0JuVWlNT3Y4VDVTVDNQWFZ3SmJMUkM5ZkJ0dm9OQVlIdW5MajloTVh3SERw?=
 =?utf-8?B?VG42QzhjWHRNM1JvM0ppcUxjbTNFVG9BdEdoU3Z5QytuSW9SQkl0S2lESHBW?=
 =?utf-8?B?dGo2U3FoNFNsNmcvN2d0WFM5MVF0TjlsUmJud1NhWWFZWUpDUjYvbEx3SzV0?=
 =?utf-8?B?eDI1eE9UamdJdWsxbTREMER2YjRKY2RMYkR6RFduOWhJd3ViRC9qMDRKQVF1?=
 =?utf-8?B?c3dSWERaOXlnby95YnlIc3hVUkU4blBaRDM4TUZCY0dLdUN3cVk5eWlTbnpj?=
 =?utf-8?B?bXFLMkoyS0lyZ2Yrc1pmTDJIOGsvN1J5eUhHVWR1bkRlWUhYRmJlL0xCT1Y2?=
 =?utf-8?B?TVVTVVlOUHYxaE5ibWVMK2hCUWJydlp3UWdFZCthcmlHdlZHQnI1NVRPZEJr?=
 =?utf-8?B?MkI3WVpwQVdFRlRkaXVMSno0UytBZjY3OEc1UmVDNzVMdjE2RVhwMm5GM2xN?=
 =?utf-8?B?UWowU3R4MzF5Z1NLbnRlVDJhcVRPQ0xRS1E2Q2pQa3g1RzdKSWJ3bHZuOGs4?=
 =?utf-8?B?QlhDaFROSkxsN0RtK2tON1Y1c2hQcWlzendQdmwvMUJPT2l2eXVMY1J1a3hL?=
 =?utf-8?B?ZzI5Zk9lWGNHZ2xJbzI3WVFHUWg3aXp2ZHpUMW5PU1gyOEF3dmxxQWpiWDQ0?=
 =?utf-8?B?TXVMOXFGbGhKS3orT0ZWS2xPaXVaZjMrUlZVNStrOVlvYW1lbjlZWVlhSVp5?=
 =?utf-8?B?RS9OUFJLYWlVQVdNV0JxYXpxM2xINll4NWNReUk3TjYvM0NCM0ZCUEc3amhQ?=
 =?utf-8?B?bzB6V0hMT3VHUi9WRlJkU3A2L1IyeVpkYUUrSGJuK29vOFR0Rkc5VDNtdDJy?=
 =?utf-8?B?cXhjM0gxWmVLVTFhWERmU1MrazQ0cURQUTBKSEFKQ3JQR3MyWTFZMGVtOGhR?=
 =?utf-8?B?d2dITjVXY2ZRZ1BoR2xhSHlnOGRJcEhQcGJpNnhLYm1ScDNJNkFydWZtVWxr?=
 =?utf-8?Q?YnRhCLTItBhs6MIt5dG3ZImvsJFNbMoyJrEBLfyGTIRftp?=
X-Microsoft-Antispam-Message-Info: JSnuYVuzHAeJsxnxZxdjaepULLBN4qvK2e9gEZaqouqMjQNo7Kc905UpeFwSf7AQVlrubHypSYGmIdUhzMRf6ZDi8x2wj3Xsk7br/6Q9KDY76+5SpzIcBneJTvq1xpoKoSea/QvTRIDhX/IC6urTP4fGFmFFjP/HUVoxgPsPU00lXbxzhiwxITXh1o2CKadTw7TDpw5JkP3tLvRUNYnD0RknpeR9o7Sc+dasSzS1eUnBJafVfVEmU32+nwLYRdQEoUk7ckx8QK0LQTdGQRAfIdlA189TTUv4ClEvELotyUl6dvbq5MVT92SQnw+NGThlZz1n0kBzvqSiNSLo7k++jmUugBfvZehOpYtNLX+DaAw=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3202;6:LBUugF5tLhdHqkP/3PBhCsZrHHKn2Rgk/PVVvDHiUKgfUC670mNC/AOZbsF06YHgac+S+v1tTT0DuimU2hDsuaZXq3FP5NDnsMLuLjB7rl4tH+vej6MguPsPDIISXk8DY5Ji6mSdrp/LjOAXfsNzJmGqU9tdU05JBoD6uFFLi2/tWNug2Ztfr6m+qesfDSwXCol/IpSNxcdpzMoay4yZgeDEpsqOMe51mqfhgf8vPFkKRalI2we4QTZlyHjnPo0A1NrPX0wavefE1Jz4RBQFezSL+6yOy+MkkI902yn0VGcpm4nkk88//YS9Dkn7cwdp2hzzTlJxF7AuvOqjOQiE8Dyti3EBmknoqwAB5w6chX5A/QWIgu1ESHPp0Y5RGncu0SWyW2fjB2dVFCPFCHiR/ynDJXdjHsfCltxHwc0p6XWcxQzbW2/Gf4KMBPztOyzNTGEf3X5XBt9AQrpp9r/Sow==;5:vLwCqiFHNxXtttc7hsXplc/mjfFrw5/KK4kNa8jvkgYi+zCFsSEJFJZzOgdtLq3gZSrzvb8KXjb/UStudsGAHXnz8Rps1Q6x1mcN/a0pNC9kVFPihR+USrBIuKRQVlL6lM9RhVuCvArbK1rY2yOJmrcTGWc3HLuGCTI8XfETyBg=;7:hgNVjVHFamNAin3WxFsvt5eiN2/wZjTtGewSaSmPT2RbYSpw7tjMAOwRs9K43BaUqbSP5pb6mI2pgPGE0aBt3DIpyPCNSCYTzY4JTIotDgAY4B2k7qqi/2wrFLZSlpNm1v9Dri+N/sW1wjhVsHcVmYZIILhMrfIO5a4U6OLxN0P2lfrL5+MZl2mI+dS3+oUS2DB+5azogt2MKdsVOCCTmebmxm/ovzTPprAT+jcQObGN3vrnJ9CbFg1Iv/kqyyx8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:51:06.1696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41a04d8-49dc-4aa3-e75a-08d5f0b42320
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 06:22 PM, Boris Ostrovsky wrote:
> On 07/23/2018 09:26 AM, Oleksandr Andrushchenko wrote:
>> On 07/23/2018 11:38 AM, Oleksandr Andrushchenko wrote:
>>>> data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c: In function
>>>> ‘gntdev_ioctl_dmabuf_exp_from_refs’:
>>>> /data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c:503:6: warning:
>>>> ‘args.fd’ may be used uninitialized in this function
>>>> [-Wmaybe-uninitialized]
>>>>     *fd = args.fd;
>>>>     ~~~~^~~~~~~~~
>>>> /data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c:467:35: note:
>>>> ‘args.fd’ was declared here
>>>>     struct gntdev_dmabuf_export_args args;
>>>>                                      ^~~~
>>> Strangely, but my i386 build goes smooth.
>>> Which version of gcc you use and could you please give me your
>>> .config, so I can test the same?
>> Now I see this warning which seems to be a false positive.
>> Boris, could you please apply the following:
>>
>> diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
>> index e4c9f1f74476..0680dbcba616 100644
>> --- a/drivers/xen/gntdev-dmabuf.c
>> +++ b/drivers/xen/gntdev-dmabuf.c
>> @@ -495,6 +495,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv
>> *priv, int flags,
>>          args.dmabuf_priv = priv->dmabuf_priv;
>>          args.count = map->count;
>>          args.pages = map->pages;
>> +       args.fd = -1;
>>
>>          ret = dmabuf_exp_from_pages(&args);
>>          if (ret < 0)
>>
>> or please let me know if you want me to resend with this fix?
>
> Missed this message. Yes, this obviously fixes the problem. And it is
> due to the code fragment that I mentioned in the earlier response.
>
> Which patch is this for? I can add this when committing.
Thank you, this is for "[PATCH v5 7/8] xen/gntdev: Implement dma-buf 
export functionality"
> -boris
Thank you,
Oleksandr
