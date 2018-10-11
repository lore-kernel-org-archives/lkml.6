Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BD0C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7C32085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ter2JRsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7C32085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJLGGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:06:44 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:60843
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbeJLGGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTwGh8IobSN5QwwHB1giFMyLA6lVNmyzXSoG8QiGjvg=;
 b=ter2JRsmvaeVnYxEekgG1cH7gYn/0zzhxp5qPm3T5ZuQYIy84oTOtkk2pcIvDUxXAjM5wENzXjqojNFyTmewqNuNjYeoYTPhjj1Q2ruHffV3qOG8z9Q35xQv+rjibEa1HUBCeYFKSFuym7Rh/uweUXUTrN+RidrRFOLbaUr3PXk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from [172.27.226.80] (165.204.55.251) by
 MWHPR12MB1709.namprd12.prod.outlook.com (2603:10b6:300:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Thu, 11 Oct
 2018 22:37:20 +0000
Subject: Re: [PATCH] drm: amd: Use kmemdup instead of duplicating its function
To:     zhong jiang <zhongjiang@huawei.com>, airlied@linux.ie,
        alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1537284932-62278-1-git-send-email-zhongjiang@huawei.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <34aa8a8a-c605-b208-9a97-743beb4d64de@amd.com>
Date:   Thu, 11 Oct 2018 18:37:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537284932-62278-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::44) To MWHPR12MB1709.namprd12.prod.outlook.com
 (2603:10b6:300:111::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1f2584-697f-4b9e-bbee-08d62fca1b3a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1709;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1709;3:gcE91POw5ze6YEFbhacJKlI7AF+2KlS8VVxLkLgaWdSjBga9TefReCOJh+AI0mwYuLn+ypX359Cvgo/P3ys7uXmQXYKN8G5s0upe6eetrxUZEJ5UxuLHe+H3qpGuVbUCjFsDkUx2AM7WQzLBp5TH9/I6w/aUlx4OnPkxejx3Z0FDOGsy8Smkb6sQTfScXQ0a774wE30CXLNfVHC+VZMqAEYeRZYBdmXKxtXZ+Da/y3cbZ/6ZOoSTeFUfCfCUiqaE;25:nYV5mTU404RG/SSzRusZQVCMvH/8EEEfLalChJ/nGH2uuPrs+JP2VNHvVS4tO++hcmdtoYZfNrWadwUBzBkEsxCqNkVphzBOTi5tpfEhXXnkoxdNR3cSFa1GJdBPmndov9D7DG89/moneAbyFWwGWqXT08sNvuWv/udVE9m/iZ7J+VPRnfsBSWLnPEKzpPCOmsMlzCn8kFekz1YqGpdrIhYQrAFk9VEPZV92zNj0S6YJdmzMXz+1IwufzdIxd69HHuS4iabxjjDk99MelE1SEFM9vG5b4gcDhdKLPUnDnAumbUcbBCKK8wnG/xGDHvu+7knrrCJmFUS826GDGZz0jw==;31:S6ACpZTVLk4oN42RYcXcJJwU8kD/pGU5l/59ZwFJayKOxV9PCGpdbGlF6HUv0woOiX6OkonWuF9/JPLWVOv1R8p3Zrt8wbabcMCBZnnoZ94zuCwFqKIgaKpZrqgI37sVpdBEMLUsaoCAfzcAtc0NlFZI/wxIcHJrJ+mlU1h2V+Syngxi3Q+bo4zzKzs3e/87wAXSPtN1a94B+0lfdHDgpjCIaI8z/zBQK5AY1mypaUI=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1709:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1709;20:xBCGBJvfRW/F1CN1JnoTF7HT+pYTh3Dbcb7Od7JlEd9YR0+YAKbx1a75TpgpfVilE9kNaQhoSduLJefhfgWCa+zWm5Om39zuqUUZdw7D2HaCCaMfo7xg55DIFsoPKoaIwvNQ6dYo30PnjhyvjU0qpQgK+t6wR3ma36JuXQiwt2ti0+ZGPHxOuDVBXWwlfO1TVxK49+zfsj/N4XiqfUGycCE9PI8TDrN+L8hIdRmLf20cP4nZUmz+pcGl4jBYbzjQeKj8An0WNnT3gTyKJDTsTl5cveJz7zc5Op5Q/A9i/oQWWFO0c9GtipD1ER5TpAD0Pq1UntxWoIFYKcD1YYP0WxIuuSek1uE64K9dncYAHYWdaLUQ+PuGPEHwhsYeHawzUjEJzajUbecxoVJa03w8s1z+NQM2BCBHluOx+XomjLaFqCZsCELwyYRaCUxO5HLT2mGFNJcKrIW7/LU8mdqUVy4zcB7ATeJG4wCz/TDG5hcHSzP5fXxJX329CdqUnfUf;4:XdlbUUF90iqCwwuoqUj6e0CLjlVb1zQj5oGhbSMEskf5CIQCkJhRYkoXaQnooOi+iAON6LnTgscEi9j26UurDRM6QsMhuEOjNwmHc8AyCXR43LwcCOMtKjfv+GTz/j+L6kYPgBlJaxi9kjOhZ+utiuimH8/SOR/b3agtjr/3dTENtVIxwtdOv7Ak/1TK3Knj18LBwBYT+A3GNMtW1AOTxcqmeDIlkaR0+QCnheQYH57FEpHkTm86fkdDB3EYmx5lkU21c1kb6bwqSF6nSZE38FkrkDyaMXfbE5QdPWvR+n630yPqjvXELu7xxvvdoEC0
X-Microsoft-Antispam-PRVS: <MWHPR12MB1709632550A9C443C6585ECA92E10@MWHPR12MB1709.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:MWHPR12MB1709;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1709;
X-Forefront-PRVS: 08220FA8D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(53936002)(8936002)(86362001)(31696002)(76176011)(36756003)(5660300001)(65826007)(25786009)(4326008)(3846002)(6636002)(31686004)(52116002)(6486002)(2486003)(36916002)(23676004)(52146003)(105586002)(106356001)(229853002)(6116002)(11346002)(47776003)(446003)(186003)(97736004)(16526019)(58126008)(66066001)(7736002)(2870700001)(65806001)(65956001)(6246003)(6666004)(486006)(956004)(2906002)(50466002)(16576012)(2616005)(305945005)(476003)(478600001)(72206003)(44832011)(316002)(64126003)(8676002)(386003)(68736007)(81166006)(81156014)(53546011)(77096007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1709;H:[172.27.226.80];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzA5OzIzOjRQcDNyRGhWTE9mUlZQZjBYYjZmMWJVV3cy?=
 =?utf-8?B?bGRuUFQrQUVjSHhyQTI1ZzJFeThRWXc2ODh4Q3lPWEZZVXRmdGJhY0ttby9H?=
 =?utf-8?B?aVExcklYbHVBOGNZYVZVMVFqeS9aTHZwcHhrUzVackR4bGk1a2ZVL2xlcy9a?=
 =?utf-8?B?RkZvMkZMZndDTlhJa1BNbHhteVVtUUlzZ2tBdlZ2SkxGd2xBOXZJT0pYY3Zt?=
 =?utf-8?B?ZXY3K0c4bjRkL0E5VGFCNHc2emRxY3hhT2gwaU91M1NTVkpBWVZkWUxVbDZz?=
 =?utf-8?B?NkhuajZGbU9oU2VMcldRUEY3YkRpMWNlTzkwbk5OSGRHM1FRMDRRdStTQVhW?=
 =?utf-8?B?QjdrT0JJeUNKWDlDNXgvd1lDZzExaUJ4UW9nYU5jVHVvMVdGUStBdE1lZURp?=
 =?utf-8?B?dWJya0owODFKK2ZWeVAzenBMWnNsbjdCd1NFeStXZW8rRWdYZFFrNUFTWGNs?=
 =?utf-8?B?NWROMHNkOWpBelpTZ2lzTVRsVUVSTktmUlZra3VqcHRtREhhME1vSWxZMGIz?=
 =?utf-8?B?aEZJV2ZoODA1Tm1sYUdVa2VaTVltN1M2cGVKTHZaNGlIUER1TEtlQ1lzZTNl?=
 =?utf-8?B?Tk9MeWpWa2lMN2ZTaEJkNGFLSU9jdVAzOGU0cFV0MGJyU0ErVlNyenA4YVdB?=
 =?utf-8?B?TGluRjdnU3dRS25rLzZQRlFjejl0cDgrcTZTMExsTTd3WlFZS1lkVmVFeHRi?=
 =?utf-8?B?YTBhRjhLY3hDVnFmQ29rUnlrK0x4WU5BeXRXZTVBdG5ZTG9zSlo1ZHptcHk3?=
 =?utf-8?B?a0VRc3JwaTNVdno5elo5SmtFK0NUQW5CWlZ4QkFNR3QwUEV2d0toN1lhS005?=
 =?utf-8?B?TGcxTlZhbnd1RmJjY09XUlY5OU9zNmJiTjRJWjdaZTdjMWhXbm9RaEY3UEVL?=
 =?utf-8?B?QytTcFZSSm91VXNyMmdJMnNPRytpbkZpWGs5TitRR2RwVTZEenZrOFd1aUR4?=
 =?utf-8?B?dFhtU21PcGRpeVFNN280VEZPQzV2bG1TZXJCY0s0aTNhWFpFQXhSTEk5L2sr?=
 =?utf-8?B?YmE0aStHQVhTdDdaU0JLcEY5UCtBUWowVEJrdkc2Rk9NS3JuTy8xdmF0c0Jv?=
 =?utf-8?B?K29yQlduV3dVYVZudkZtdm10Z2FIM2ZwMmppRzR2R0V2TldCcE15bU9JbCsr?=
 =?utf-8?B?NitqNWJvUFg1UUVqbnNHWHpKeFdiUUxyMjNXeUUvekdNNTNSaXhFYVhoTGRG?=
 =?utf-8?B?Vnd4T1VwSTY4V29RTGlUdy9MY1BLWDNrS2c3UlZkSmpRTG8vdngzbHJRVDZj?=
 =?utf-8?B?RUQ5UmlpYXplRXNoSWxGWnJuTy9PVjQrdG5zb2pORkcyNktOZEYyQXRFL2Nz?=
 =?utf-8?B?Rzl6YVl3UC9NYW1LZCtYaE5teFBXaGZ4ZHBtbjZvdEZFSXk0aGlLajcreWRB?=
 =?utf-8?B?V2REd3Q0UGR2bDhDRU1qS05lb0JjeTBidUNQMGNNS1dCV1RiSGtEbjk1emtu?=
 =?utf-8?B?bkVRMlpIYlA0UlYrZ2hLc2ZBOVJOSHM1UFVya0Z2aXJwYWFUL1hwalF6MXNP?=
 =?utf-8?B?WmtaRmt4U3cvQXdEYUFmSzZpR0NoeWp4OHBmWlBnZ3diNGNMYWJLOHlON2I0?=
 =?utf-8?B?K3hSSXlHMnRJYWlzd0U3ZjlWNmhLOUlNRWkycldwU3VvR2hFQjlqVkJvUjJH?=
 =?utf-8?B?MGNWZmxEWVR2bWxWOVJRK1RTY1ZnUUFlTGlJMmxjeS9lTXlKTHJTWnVQbFVZ?=
 =?utf-8?B?SnF4aEQ4dEVtNW9vd1MvSVg5cGdaSUJVWlUzNkN5ZEZPWnhGWk9jTTk1ZlRu?=
 =?utf-8?B?NUJZeE5ZaWJDc1JjWWFwQXhFRWhtd21lekpRcVlKaHRCWHhoa0QyRkZzNnNi?=
 =?utf-8?B?cGFIOFZzRkZFamhvZTFvcDZtS2dHK2pocEh6b0Y2M0Ryd1FhckFrZ0VGMyt0?=
 =?utf-8?B?SVhoQTlocFpSY2gzakJJVXlaTHFYd3dBZlpaWjVzYW44dlZRUllYTUVpV1JR?=
 =?utf-8?B?Q2RxY1BGTXVOUzRya2dYcHdkeGhaWW9GLzZncFN4dTN2MG9uR3M2WlZGd20r?=
 =?utf-8?Q?DehBoS?=
X-Microsoft-Antispam-Message-Info: cDGnQxJtuwA2MBF3uDtLXzufxAi07ytukgQZ3cZ7UwTWa32TAmny3n2EL9tBxNOZXMd0NkzBeKNuMFPfhDl/RtNUJAWSnAYB26429jwafx/L3e/eSfcp8I32aYTCMqFx/275x3ULLkWBOo8kEmc0nlEEJJTrrQFRAY3F7PDqbrWn7bA7cSjfAEmxrm9kXphcIEwgHfHeWAAAmryvvk0z2UNz+NWEW19gKAsrTp5diHdUcJMzzyPHPN8w1ToR+RI+/ebEWozf+rDEeQMjHWskM/pLTKHrSx/Cr0K66XpWE13KWnB0Ech0Drd53tN1Oe/FBjdDZfKTlP/yvmIVBDbWss93j93lz+v74Y1tsdbbzOw=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1709;6:UYQxMzXyOlFwDBuLp+9Ke5/YLZSBDmUgFNSBxisl1Pxige4fcYjNcl87AmhmYYIwQVdiCvKHyD1W+MNvs6q62/WOoQ5kIIj+KN06gPyJnYSbzXOlTkpgHRlpaShbjXT2Mz6+EjaYL+3nafF12hGJDg0qOt3WSwzrnaWtHjj5HfwpCke4E3fQp4pGCLNLvTlPNzPDaSE7F0/xvXY9duPVQ8ZoLwQvHsKGxlo2afw8PhdWjhyKQKBZ820x6XkhYEhZqe7p9Go0n8Gv55GnYLFXkklFJpwGVdAusJSaIav47rieu4kWMqJOfKaLXhXxiY1SuWeoe9yLbW0Z2imK+vN9iXkeAcNAuRXMmuZheasocqCo98oVXDaq4PZXjQvUQJR7U1bUuOMZvGc7oOP9hT6ytGrcTlgzOvWZEWkD0rch8Dg5ewYACSYvHLPLT1sZZAiOB6DjiIcCghxD1QLhca+q/Q==;5:3kt6NI3unrp/1pP87oqjrqnrVwcUQy3xaWY8NvlXKqAS2zfG4DTLUTGoBoDNGT5tY9oKoEbCLK8uuP/lEcver5Y8RIJoMiCybB+rzGeGHtWFJguw4t07mxckC7mUzJiql0PKJ6DFIZE4VihzSxMI/Cxkmf4zZOj6f4I58E0J8NQ=;7:FnyS3b4Kh5KkXh8avmOsVqcX6SDPkh6ykh+Mhz9lLFeK2KUBh4r5ytsMeJCbM+02x9rnhoQgFyAZIth1IFqnUf4Tw+MnzuBrqnhHSdBA/U3EFeHBWwQYgB/bXgi8IAWxc6rzI7O38E33SVQgQdXRctzbML798iSwCJWfMj78s8iqR02Z78TLaI73TXJM/4bjGD7nSfhdpi7fvjYSSEUUWylBpVeFZPI8sh/QC0p0dGZEA5/lFL6Sm3D07eleMDnY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1709;20:PLcFAqJ0pmfPd1hpo60AiNcMwsYPMdQp8vEfL8fd0vZY8ZdMScCVmKZjcIQ5d+i4ruVu3TtVzxOE0GMh2YvCBd4eqfgZTvutlMcu+laEl5rxjssXaKKXyBsbDfx7mI7pHJDSl9YCwDUKSDmTEYAwHcgNn7xP/PBxx/wiwswL/xpSnar63GUf3u6BwnurMGHjtlUxRAS6VJroQU9NZ5zh4kU+cFE2DKkzef5qP2z6ksiMKxtqpHudXtDSIkYEq4ut
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2018 22:37:20.0892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1f2584-697f-4b9e-bbee-08d62fca1b3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhong Jiang,

Sorry for the late response. I just saw this while catching up with my
backlog after travelling end of September.

I applied your patch to amd-staging-drm-next. I only changed the
headline slightly to use the "drm/admkfd: " prefix that we commonly use
for KFD changes.

Regards,
  Felix


On 2018-09-18 11:35 AM, zhong jiang wrote:
> kmemdup has implemented the function that kmalloc() + memcpy().
> We prefer to kmemdup rather than code opened implementation.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index ee49960..8ddd585 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -747,12 +747,10 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  		return -ENODATA;
>  	}
>  
> -	pcrat_image = kmalloc(crat_table->length, GFP_KERNEL);
> +	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
>  	if (!pcrat_image)
>  		return -ENOMEM;
>  
> -	memcpy(pcrat_image, crat_table, crat_table->length);
> -
>  	*crat_image = pcrat_image;
>  	*size = crat_table->length;
>  

