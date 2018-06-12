Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 45CD7C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EAC208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="U0sZQU5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EAC208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nextfour.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934043AbeFLO6q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:58:46 -0400
Received: from mail-ve1eur01on0065.outbound.protection.outlook.com ([104.47.1.65]:26318
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933574AbeFLO6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com; s=selector1-nextfour-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxfHSVvHS9tf+FqQnp2E3Jq3uWpWwgMUS2bm3n0djWY=;
 b=U0sZQU5HkWpjgSPyShA8pGDA83nPlPVrdm4afMQIpvRBREI9uoNAHI5XAfBzaM5CRBQ5L3izq3Xb7QjD0Zm6d6V8IkT+omujO8495a7prz+LcoRsIWHFys/jqnq8wYUdilrooPKu9BBInTN2piY69mGsaFUVswq8O0ykbi2g6Sc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
Received: from [192.168.1.71] (88.193.232.20) by
 HE1PR07MB3337.eurprd07.prod.outlook.com (2603:10a6:7:2d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Tue, 12 Jun 2018 14:58:41 +0000
Subject: Re: [PATCHv3 14/17] x86/mm: Introduce direct_mapping_size
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-15-kirill.shutemov@linux.intel.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <030253cc-2db5-8faf-15ef-bb7828c5f624@nextfour.com>
Date:   Tue, 12 Jun 2018 17:58:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612143915.68065-15-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [88.193.232.20]
X-ClientProxiedBy: HE1PR0102CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::21) To HE1PR07MB3337.eurprd07.prod.outlook.com
 (2603:10a6:7:2d::12)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR07MB3337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3337;3:zbXMOCcZ1Tqka4dWlAuzsjd8UyFmWPYNNoVfFkU6so7IkF+GiAoIcMbasTQQUBLHyVXZYy7x8Vm6M9rpebvWu55OGj1PTaHQED6CFvj55u1JJXSYG3XZ1E0gwuJXjZbAzjGf1pfdxRLUILTujFkNFrItL18scSR2nQvmLwyumPo0OmCKAJRKnV9fa7qDCmIQHpF2zuUVYS/0pdioI6N8WG7paH2ol4kOK5g37rAsuQTv8kNiI8p736o8Bm47/plX;25:vRC4jomd2G0xx2t4tE/Fn93C/aeJAi9SZcretqqvI5ao1VZ5/PrnFgnygNNvzHMPvhOglhq0fCunFVhcmL7ECcc8zeGIbNvQsegBeZKnnNq7Hirtk3qmoYd0GOXyMnS5hUmCjdSpkMTQrduQhkmCzSTujySgOef+uOVKA1a0bVgCTqnszWKPU8mJeHAtHD2VuvK8jQDhERDc000wl0Q9VR930WN4YoCqA0+8tCnPUrR6hRk2vubYh3MJqqoCd1btjqSWfjYM+hv2PL4QoI8pgAg535ZnlC4KdVzJBnsD1I/7qgWXnFBe9NT5LQpQkqMoDAgtNHOZcTSVguCz1+z9oA==;31:XFILg23II6Cge6hrCbUKVuirWys+UFHTBmQpZJdWAOeGsgBkSoWmAbEPqJA6tMBo7LB8IFU+9iNuscN/Dep30fVDQ/s83Y6IRUOV0TTfoQluFeGY2rmDct2+g6rhjlj0O3iqb0Wo/EpSluM5QxiCty9oJT+/fWqe+rZdXzsV2GqsOVVQX8/m5iPPqIqW59vXWisbiP2x5rI5ORn9sp+YqYh+OAR50Ge2pqZvJ69CPGo=
X-MS-TrafficTypeDiagnostic: HE1PR07MB3337:
X-Microsoft-Antispam-PRVS: <HE1PR07MB33377C76A4E89C9D1751D65F837F0@HE1PR07MB3337.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR07MB3337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB3337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3337;4:oUon8p2SuwJs8UxuxPQVifNOwc2Ki5wRaaRMWu4LrnEQXZxhamJeEi5dWSI3aB7ejw58nAVoydTAjQ7Y2b0IEPQVu2tUFGN4AAtsxC6jeP1AHUpfGmKhEMh1QS9NozAvi/946xScyKzt6FuMEAqE7U4NZ6MLE3vHfxLKN+PkqaeSBeO+X8BMv/LtgxOUq241wzmK1aoCd7k2R7sV/h6SBLKWfqYbSW3aJb7dJVMGSUYfDtxBxO3cK+4ceDnGfjANE2VHV6uVlDFHYOKtE6i9cx3xNdSh8902A/fKQgYRRDEAQJTT5iUF2wHzLCtah06h
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39830400003)(346002)(396003)(376002)(366004)(39380400002)(199004)(189003)(5660300001)(186003)(23676004)(230700001)(386003)(64126003)(2486003)(52146003)(6486002)(6666003)(36756003)(50466002)(7416002)(59450400001)(8936002)(68736007)(8666007)(66066001)(25786009)(4326008)(47776003)(58126008)(77096007)(3846002)(6116002)(53936002)(6246003)(65956001)(76176011)(65806001)(52116002)(110136005)(26005)(117156002)(54906003)(16526019)(65826007)(53546011)(16576012)(81166006)(81156014)(8676002)(575784001)(31696002)(86362001)(2906002)(316002)(31686004)(106356001)(7736002)(105586002)(305945005)(97736004)(11346002)(446003)(486006)(478600001)(229853002)(956004)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR07MB3337;H:[192.168.1.71];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3TUIzMzM3OzIzOkgxd21Vb1dXVWxOZTQyQW5JcHNtOXZGcmQ1?=
 =?utf-8?B?b05YR0o1RHpoa1l2WkVDQVNZdFdPZDBHWkNzNGRyUWtsa1JpK2NoWUc4c2JJ?=
 =?utf-8?B?UWE0cHIwMEhPcFN2K1ZOZFdDN01yOENHdkc0KzRFSGUzaHBSWk5sQVkvSkt2?=
 =?utf-8?B?clFjbEs4NG96NldEbDNMNEhHRnp1NDVGQk8ySCs4WEZkY1ZoZzFvZ25IeUpL?=
 =?utf-8?B?S3BnbzlMeEQ2dUVXVmRUYmQyZS9aWUxDbjJNc2NrZlVYb0VKeExFSy9kQmdY?=
 =?utf-8?B?bm5SYXc0cy82ZzVqZXJPSVduT2toTFBCbGRuOGJKTmFDQU8za1NsKzVuRENQ?=
 =?utf-8?B?ZUFtelRWY1dBUDdXbi9TN1hGdHMxNWJZbmZFLzhUNDR0RUFJVUNYaGdTaXgy?=
 =?utf-8?B?OUxFVkFlS3BEM1UxVEZydVVrUUhRWVRpVmF1RjZicE43c0M0VVVzbEF1RkIw?=
 =?utf-8?B?THBWOS9aNWpUb3hxV0d1UzNveEFxNzRUSmNQOWNKKzhKVS9NT21SMnh3TVhJ?=
 =?utf-8?B?QU9HQ1EvNHgxRkZGWkR3RVVWdTA0UC9paTkwM293Y1dGYU9VTFVkbDRvR2NW?=
 =?utf-8?B?KzNvb2YzMDQ4UHQ4OE9GWElGNHBhcG1ZZy8ycThsazhwTHlHRzk1QXpMVVBy?=
 =?utf-8?B?Wm04blZ6b05QY0FCcmZEZ0xJQk83SjYwcHB2bFhWdTlhWVpmSlowaE9nUHBI?=
 =?utf-8?B?VWxxd0pzck5kQ0MyZm4ycEt1TlBLYTJwWjNQN1VZV1BlYjRXN1pkUE13K2Fa?=
 =?utf-8?B?QjU3eW9WM2VuVGU4WDdtNmJsU0dRdE5xZ2hWdTNWWUlqQk4zQTZId0doWTZr?=
 =?utf-8?B?ai9pVG1MemdmWEpnRDF1ZzZla0toQUNtV0c0OTFuUTFoa1hMRzhHVE5aaVBt?=
 =?utf-8?B?ZXI3ckVwQUlHeXU4OFgzektXbExTRjZGWUk3ZHlrMVlqNm8rNzBBSC9xRUFk?=
 =?utf-8?B?V3J3dDZPTElYMHdaNnVLQkZQbXFlMzN4U3VDVkVHOUJMVDAzQ0ZDTGNnb1cw?=
 =?utf-8?B?bE4zTmpubEdZWThaalZDWlVTbk0xdm80bmgrM3JXTjJzblN0T1VWNjVTb1RS?=
 =?utf-8?B?WGdqcUdHeW5CcmVoZVNtYVZkQW1PREZMSHpsa0VpRnd0Y0Ryem04UXF4bW81?=
 =?utf-8?B?RlNuUjBsTEdMbWNjS3FnYlZETDB5Y05JeGJzd0JoVTZqRytkRUV3V3FsdURn?=
 =?utf-8?B?c1JNNkwxdEJOeExHOFVHdWdRQnZ5bDZEVnpOTW4rTjVNdDRYNi80N0VwbjRv?=
 =?utf-8?B?eEplWW15QXFTWGk0eFpnRkNPSTIzWHgyR09NU2x2MDJiUFEzMTJtd0pURVVM?=
 =?utf-8?B?V2VjNWw0dGFxcFBObTI3T0NKZzV0ZlQrWEhxRHhJYURZbC9GdHNEOGZLblFR?=
 =?utf-8?B?N1ZoaVRZRnZBTDFJcEZWNVRaRms4QU1uUWpMdGYydU5maGhrRzF1R1NWOTlj?=
 =?utf-8?B?aUwxQXFqak5yYXgrNFdkQ01yMzhxZFo3d2wzaW8vOWVFZWY2Y1VCa0U0NXZn?=
 =?utf-8?B?VkhuQnBPK2gxN1E1SjdCMVVnakora1ptMWFDMFVrSXRESmJVc1dhT2RVWWJu?=
 =?utf-8?B?eHY4Rm1aZ1o2N2I3b1hzeFpoQ0hKeWsvVGhCcEJ1VEVZL2xqNTlId0UyUkFv?=
 =?utf-8?B?Z1dzYnZIdTBIekwyYmhYeHlYT09CUEt4VDdicExiemlqQlJnc0Qxek1GOHBB?=
 =?utf-8?B?ZUJxejNyNEl2dlJzcEw5ZjhwYmtld1hXR0gvV2ZxTG12MFQrLzBRRVUwWkZ1?=
 =?utf-8?B?NU10b2Y4TDh3UXNjVmFaSHdDSEFUZkdXR0NIYkN0a1l5cFNidWhLVUJUT2gx?=
 =?utf-8?B?Q1NEc3hqRWxScTRDQjg2Z3l2eDVDbEhlWGROcFAyMWx6NDVSeEhiTXNkbkdr?=
 =?utf-8?B?N1ZUUlJDckdxVmxwSUxZUUJuY0pielZIbWV1ZFNiRDN2bWZZYzJ1NjlVMkRh?=
 =?utf-8?B?L0NrRXRiRlR3NHJlN0RJZ3ZiWUFuMy9pUGdPVWoyRFZSODY4dUg5Sm1aL2ZK?=
 =?utf-8?B?N21VUVZQU3R0OGxoUHNZYUt4bGJNRU82OW03TzJaNmVxWnd3a2VRNjMrTUJL?=
 =?utf-8?B?b0IwYkJZTFJuWGU1eXE3RnJvcmlxaWhzU3JxMGk3TzVONk1QSUk1TEZPa0tm?=
 =?utf-8?B?RVE9PQ==?=
X-Microsoft-Antispam-Message-Info: 28agItoIlYQArn5F5NZ8uCZwc6Ei4fX8z7NG8crERiiTX5obKkbqcpc+7ommuk1r4A4foA0oHifFeP+Aj394erYqu1YPoZNqD8EquikSIVNHO9pTA3OFrp86zlTQ02co/yEU1rb85pnQsof0SnNzrkcadC0CIqEb/3MIR5FhfwpvYAVTUKG9cdlmCHREoxmi
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3337;6:i21r2rKhTiz/wNb3v5Lncpe7CYWl3SxfsLNPM5PkgRAWc1HQYKtcO1kx7004ibD3NnTHlGGm9cQqHZx0sKFinvrhjuzcpyUDMZe/72SZ89a8vyTFJSlyTQa2Ux2dxmxTYxQySPMxmbQz8jh7L5VnPsPF7T4s+ztLWIdrO46i9tDnLEzX8/P05c8ByghmUUJegDZPujZAI8gq/KLPYU6x71feDoLH2Vj8KRVAekwpxJ55KOF2bwKVJskUDZGjN5+65xGa0FbQPi2qSrK63BXq+oVatbulN74UWJdFAQ6PcpNVbyGCO0KE3xaK8Q6vKcTFsGKcf8tADhAoAD5oNhkfynetSEUy8NfC57c/HTvRMB/aSBKMptcvPeco3mZSKzuZs3osnMLbfC/zR7SlO8tirLCn1MNwJ5H88qMsE/do+NfZxTDS7flSSpQk/YnIhlT8S8fuglJswXYoTXGdTD952A==;5:5iIrv1QR3zrqCf46b8uO95zO9zjiYEpyF0KZqmHbUHLosC04jnkdw6wMZo+ET2UXXZGeaCxN/ESRYjBfFsn+X4k9rsyhvGO7o0DFFh73qAZcEcJ4SJeEZ5pTyroZ1OPA7ChBrznqX/MNvhYCqyN7JfVkqCXkQaN6OM4wxq6FYkU=;24:anmboDTAqREEbzGfJGVjkMbZ0tdo3REfgVURcXceH8zeS+B9h0E9h+cSrG6foaHGd3VkAnIWLH2kPpKtC0xRQEIlxz7WGCwNI2dUDnTyfao=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3337;7:LQlXzZQvf9OSkSmCybCFyDNuj+rMTxfrZciUru3QPIzb3+rPlKswC7cnNfoyRBIuh6OtqSxXs0hCgHOzGagiAJxL0DCMU1+PGY0QUR022d7157kBmL+0H8wf+rbkRyd7yig5MCJDAQU/SKFc6CpE5Cwi8XkKFN+LasC83yWwK8EHNQPd4yfZwDz8ChHumkT6maLuy7hKKeYkLICn8OBqssScMM2rXEofs7FKrcjMah9oX+o+r4zt5ckJgWBdudm2
X-MS-Office365-Filtering-Correlation-Id: cbfedf3c-88ec-4f43-e718-08d5d074fcc8
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 14:58:41.5799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfedf3c-88ec-4f43-e718-08d5d074fcc8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.06.2018 17:39, Kirill A. Shutemov wrote:
> Kernel need to have a way to access encrypted memory. We are going to
> use per-KeyID direct mapping to facilitate the access with minimal
> overhead.
>
> Direct mapping for each KeyID will be put next to each other in the
> virtual address space. We need to have a way to find boundaries of
> direct mapping for particular KeyID.
>
> The new variable direct_mapping_size specifies the size of direct
> mapping. With the value, it's trivial to find direct mapping for
> KeyID-N: PAGE_OFFSET + N * direct_mapping_size.
>
> Size of direct mapping is calculated during KASLR setup. If KALSR is
> disable it happens during MKTME initialization.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/mktme.h   |  2 ++
>  arch/x86/include/asm/page_64.h |  1 +
>  arch/x86/kernel/head64.c       |  2 ++
>  arch/x86/mm/kaslr.c            | 21 ++++++++++++---
>  arch/x86/mm/mktme.c            | 48 ++++++++++++++++++++++++++++++++++
>  5 files changed, 71 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
> index 9363b989a021..3bf481fe3f56 100644
> --- a/arch/x86/include/asm/mktme.h
> +++ b/arch/x86/include/asm/mktme.h
> @@ -40,6 +40,8 @@ int page_keyid(const struct page *page);
>  
>  void mktme_disable(void);
>  
> +void setup_direct_mapping_size(void);
> +
>  #else
>  #define mktme_keyid_mask	((phys_addr_t)0)
>  #define mktme_nr_keyids		0
> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
> index 939b1cff4a7b..53c32af895ab 100644
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -14,6 +14,7 @@ extern unsigned long phys_base;
>  extern unsigned long page_offset_base;
>  extern unsigned long vmalloc_base;
>  extern unsigned long vmemmap_base;
> +extern unsigned long direct_mapping_size;
>  
>  static inline unsigned long __phys_addr_nodebug(unsigned long x)
>  {
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index a21d6ace648e..b6175376b2e1 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -59,6 +59,8 @@ EXPORT_SYMBOL(vmalloc_base);
>  unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
>  EXPORT_SYMBOL(vmemmap_base);
>  #endif
> +unsigned long direct_mapping_size __ro_after_init = -1UL;
> +EXPORT_SYMBOL(direct_mapping_size);
>  
>  #define __head	__section(.head.text)
>  
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 4408cd9a3bef..3d8ef8cb97e1 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -69,6 +69,15 @@ static inline bool kaslr_memory_enabled(void)
>  	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>  }
>  
> +#ifndef CONFIG_X86_INTEL_MKTME
> +static void __init setup_direct_mapping_size(void)
> +{
> +	direct_mapping_size = max_pfn << PAGE_SHIFT;
> +	direct_mapping_size = round_up(direct_mapping_size, 1UL << TB_SHIFT);
> +	direct_mapping_size += (1UL << TB_SHIFT) * CONFIG_MEMORY_PHYSICAL_PADDING;
> +}
> +#endif
> +
>  /* Initialize base and padding for each memory region randomized with KASLR */
>  void __init kernel_randomize_memory(void)
>  {
> @@ -93,7 +102,11 @@ void __init kernel_randomize_memory(void)
>  	if (!kaslr_memory_enabled())
>  		return;
>  
> -	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
> +	/*
> +	 * Upper limit for direct mapping size is 1/4 of whole virtual
> +	 * address space

or 1/2?

> +	 */
> +	kaslr_regions[0].size_tb = 1 << (__VIRTUAL_MASK_SHIFT - 1 - TB_SHIFT);



>  	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
>  
>  	/*
> @@ -101,8 +114,10 @@ void __init kernel_randomize_memory(void)
>  	 * add padding if needed (especially for memory hotplug support).
>  	 */
>  	BUG_ON(kaslr_regions[0].base != &page_offset_base);
> -	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> -		CONFIG_MEMORY_PHYSICAL_PADDING;
> +
> +	setup_direct_mapping_size();
> +
> +	memory_tb = direct_mapping_size * mktme_nr_keyids + 1;

parenthesis ?

memory_tb = direct_mapping_size * (mktme_nr_keyids + 1);


>  
>  	/* Adapt phyiscal memory region size based on available memory */
>  	if (memory_tb < kaslr_regions[0].size_tb)
> diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
> index 43a44f0f2a2d..3e5322bf035e 100644
> --- a/arch/x86/mm/mktme.c
> +++ b/arch/x86/mm/mktme.c
> @@ -89,3 +89,51 @@ static bool need_page_mktme(void)
>  struct page_ext_operations page_mktme_ops = {
>  	.need = need_page_mktme,
>  };
> +
> +void __init setup_direct_mapping_size(void)
> +{
> +	unsigned long available_va;
> +
> +	/* 1/4 of virtual address space is didicated for direct mapping */
> +	available_va = 1UL << (__VIRTUAL_MASK_SHIFT - 1);
> +
> +	/* How much memory the systrem has? */
> +	direct_mapping_size = max_pfn << PAGE_SHIFT;
> +	direct_mapping_size = round_up(direct_mapping_size, 1UL << 40);
> +
> +	if (mktme_status != MKTME_ENUMERATED)
> +		goto out;
> +
> +	/*
> +	 * Not enough virtual address space to address all physical memory with
> +	 * MKTME enabled. Even without padding.
> +	 *
> +	 * Disable MKTME instead.
> +	 */
> +	if (direct_mapping_size > available_va / mktme_nr_keyids + 1) {

parenthesis again?

if (direct_mapping_size > available_va / (mktme_nr_keyids + 1)) {



> +		pr_err("x86/mktme: Disabled. Not enough virtual address space\n");
> +		pr_err("x86/mktme: Consider switching to 5-level paging\n");
> +		mktme_disable();
> +		goto out;
> +	}
> +
> +	/*
> +	 * Virtual address space is divided between per-KeyID direct mappings.
> +	 */
> +	available_va /= mktme_nr_keyids + 1
> +out:
> +	/* Add padding, if there's enough virtual address space */
> +	direct_mapping_size += (1UL << 40) * CONFIG_MEMORY_PHYSICAL_PADDING;
> +	if (direct_mapping_size > available_va)
> +		direct_mapping_size = available_va;
> +}
> +
> +static int __init mktme_init(void)
> +{
> +	/* KASLR didn't initialized it for us. */
> +	if (direct_mapping_size == -1UL)
> +		setup_direct_mapping_size();
> +
> +	return 0;
> +}
> +arch_initcall(mktme_init)

