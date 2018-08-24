Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3673CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75AB2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dNqjy2h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75AB2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeHXWYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:24:52 -0400
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:13615
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726601AbeHXWYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahS+gj5sDLEz2OvC4CLdbYlGD/+HsnpSMrh4q3sS9m4=;
 b=dNqjy2h7/xL5R7/jZPIEmhAio5Doxm1kBI1FLBdOM++cXYANEkBfYDiOAXCwHY5FJnm5zp6jRpuX/KXgfeBdwnk4nU8pSIuBJxEk7oRv67jlFXyYTXyN4yKSQJGNe8lXTazcqSPiYeLbPoTW0jO8eQ47yaacNpLe82oCrCkn1uI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BN7PR12MB2673.namprd12.prod.outlook.com (2603:10b6:408:29::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 18:48:56 +0000
Cc:     brijesh.singh@amd.com, Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SEV guest regression in 4.18
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
 <20180821151938.GA31212@nazgul.tnic>
 <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
 <20180822081417.GB4069@nazgul.tnic> <20180822150033.GA14200@linux.intel.com>
 <4d6ee892-a34f-28b3-18b7-1c663eb281c6@amd.com>
 <9635ebf0-7c99-6edf-1240-8dec28036a70@redhat.com>
 <20180823152907.GA1488@linux.intel.com>
 <60acb594-abe3-912f-9702-2f34961e575d@redhat.com>
 <c565ae1c-c2f0-8a43-b1f5-404c2efe7c56@amd.com>
 <20180824162408.GA5491@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ebac0ab1-6d7e-56b3-c533-20921a5d3fa1@amd.com>
Date:   Fri, 24 Aug 2018 13:48:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824162408.GA5491@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:805:a2::42) To BN7PR12MB2673.namprd12.prod.outlook.com
 (2603:10b6:408:29::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00d546fe-83eb-40a6-6bfd-08d609f23f6b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2673;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;3:vV0WY5n5lZIUI/eSxxEc/Mphs1/7xlnFn5f5UhGjx1Z3OeGDEWT2LhTZNCYyMUBz55TRwuCmU6i4upDU/B1RUsWTh0/gMUChj/1QB2OSIxcaTX6lHb7cX0TryruiIq5lOF6u2hJCnAC7wdHnSvPd7K1t5QOkG5aS6tajUOq/xsRlWO3O5DFbHLFPpyhqbkdUxb/B//cRChZJ+xE5GNS0e/8vKyG5t4+ENzAGmLJshmrrElACJXKYnlPR0RgHPGGG;25:D6cTn1bkFAdbyWh1fwRmaNM1v7MRcRJqTbz/zRVl1+abeKK1iMzdzWNiSQ1EYxUwet7CrB7/2mlnQvLVBumbz+LQS8GnEacU4frZpSKSL9J6vUaeZ/YwmmRb4a4XbN6HBMpvsDdvLN7ePtW/cynz7KbXadkKzh4DDyDihkwx5SC1QFX3bsSFC8xNiHCoJchaTR9uRi/3MTigo1umbiE897vb932pK0v6KwJpkvftpQOl4HlSmdRWpzNZ/htd6FJR7N73n/Z0Nhts+DNO2+Gh8DNM8aMlp951UJcg0OToNzn9zwUQ60JMsS0s/x7c5OeeAjLvn3D0w1kmuqyujl1Nkw==;31:DQNfGUj8ZVHtEt03uRHYgxpfdTIvz7ET9/ogT/nbeZHmjNq5tfHqiQOy+au9kRC/FaTumu3EyVN82esu6XYLERU68ExklvawujutkGwQ6QbVIUhgupKeopjLNtQTlDnLFBi9QooHFDw/XYCKRQeusJiaNkuLDTYmyE63AyhDsiODmMf/Bu1nXTP7VE2vYrPlN/4gIJD9GjtQVQWziuMoCgqNbXLK9hpXeSQD0Xa1gXU=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2673:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;20:oojhHQajd++U7AHBoFY6Xe1GhlnUfq3YoCfJ0q1WMNNfPvsjtM7e+QflmDpfOnS7IdKZy7iDI7u/OjYGvHs08xHPIUjscNev+iNiKjvTI0XJLMiDSwsHb4jYPty0V5Pon/AKRAo9/fohbOQp8G+X3+x8ttMt7XWplaA/HSbiCGslS0Xrm5oBmW36uUJYWne0OVX3ioVZvpXQj9HTyZ3VM43WxxG3EtXMS/37Gjf7RAJ47ulmSbrGOJgtUHVNW51Ks45fPXjC+AMZab1xUMZsyBL3cyvTTN0U0mjTcOX4wYXEeyOSQZQGt5B+4uA7dcAq7QXK5LpGSL4Q5tJSHmmVVc296rg1Pp4Mjnw9eShrCbPjdBcWKlzi1WlVo19+m2p7nee+ZXiS7q9DWBOq0mKLVmMoh5Y8xL3v8Hl7D8kPLKNug24D4IXAbILhHnliNfa5NYTfFyfymMKPaJSzPIzGpb+tDtElFEj3LLDP2s8G/U40zbfDjrqSUos/k/8ok+1g;4:C8N4GXdkLDOl2mzkdJDPoc4UPPMLRWPdai7wDzALqEdOGTnrC4MEJou1MpKdXKs1E7VB8zgXLE0rlqkfvWXehSwShDbRw63mwln/vKjiF5U36E2i10MTXuIZCK4f7sFe91qxSLdNx8Lzi5czc+/hxfP8l24lxxbidTf5706OzauZfEp+J1ihmR2iyriNgycjTGnc4L7VHPgzo1+SwwByuqN9A8rDbTRNG01MZkKyHBBOCO/Pu9eYIqD2tbe2L2YEsMoHO4ZWnSzTlG1dW4HqwQ==
X-Microsoft-Antispam-PRVS: <BN7PR12MB267331789011201A47312C12E5360@BN7PR12MB2673.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:BN7PR12MB2673;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2673;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(8676002)(486006)(2616005)(446003)(956004)(316002)(16576012)(25786009)(44832011)(11346002)(305945005)(2906002)(7736002)(53936002)(97736004)(81166006)(58126008)(16526019)(186003)(5660300001)(229853002)(230700001)(6246003)(81156014)(50466002)(476003)(6916009)(6666003)(6116002)(65826007)(54906003)(36756003)(67846002)(3846002)(4326008)(93886005)(86362001)(478600001)(31696002)(47776003)(26005)(77096007)(65956001)(66066001)(106356001)(53546011)(105586002)(65806001)(6486002)(386003)(31686004)(8936002)(64126003)(68736007)(76176011)(23676004)(52116002)(2486003)(52146003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2673;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjczOzIzOm85NUtJQmZVNWFJTWtyUllMcEhZdFd4VUVk?=
 =?utf-8?B?ZDV0WXRGeXhaSkJFSnZOS0FNMXRoOTdjVDBSL2pESWJGUmJNaXFKeXQvOTNL?=
 =?utf-8?B?NFNQVUpvTTVLK3FvODY0UGtSdW9zY1c3dCs5aTR1MEZhMFpsWjhEWmowWFlK?=
 =?utf-8?B?TG1uSmV0Q0pleU1LR3B6bSs0cjdKNzk4T2xwYXZPZlkrODVhVHlXdWVOaEZm?=
 =?utf-8?B?SEFjQzFmRXUrd2hvRjFaWkhYZTBQYjdnTTYyZGw2Uk0wU2dEQTJZMEVtSWZT?=
 =?utf-8?B?VjZJUUV5bWN4RzIzK1RzejRqYTBlTS9GcDl1cHg0SjdpWWxxREhBZUF2ZXhr?=
 =?utf-8?B?Z3JEU0pZY2lDRU01dmt6U0NyVVRhSnFMMklUM2pYazg5Y1Y2ZUVpc09VamRm?=
 =?utf-8?B?QjI1MFBmTFl0TVZpZmFKbGFtV1hVV3hxa3RraFNVQVdkSXFrWjhKRjZIblBL?=
 =?utf-8?B?VTZHY0tCQXV6TzRpYUxCU01COGVkV0NscFpJYnRyVm0xRWY3OEl6WE9IZy8v?=
 =?utf-8?B?ejJrYzhxRVp4dW0zdEZHYUZyRTl0ZEJNclZLbitZQ3dIeVlkc3VUekRYYkE1?=
 =?utf-8?B?eGdTemdjMStocnRDdkdBaFNSWSs1M3dRdWFwWnlTZXpMejZ2aFVyL1BEVDhV?=
 =?utf-8?B?Z0RJWDgxZTliUnBPM0pxcW5wUnllTFlVTGtBcWR6aDZHa002SUhhaXJNVDd5?=
 =?utf-8?B?WFFud1hDaXVhSXNIZDdjMVQ0SUxNbmtDanB1MmtRaUppWGt4Z1dHa3RPNGI3?=
 =?utf-8?B?MEw4RmF3VzVBVzRmT1p5ZGErcTRnUTc4TURWWG9xd0s4UFdJbVp1aFNkZjdI?=
 =?utf-8?B?MHJ2bTZZUGtPUFBGcm1UeFdCaEJtaUh1UEVtYTlSU2ZKdDZwV3o3QStxMzkz?=
 =?utf-8?B?MjQ0bzNhYy9TbXdGOHUraVBEc0N6emJnNmdYYXVTSmFFMm85L0xxRWdST0ts?=
 =?utf-8?B?TUIvZU5JTnBUQ2RQclM0YjRWVUo0R0dlRmcvSGZYSVBRV2IzbHJTTEQzMnFJ?=
 =?utf-8?B?ZUVhODNBTnZacXk3T1R4UUxSelFNM2NUcXVyM1VtU24zN0M0OXBPWS9RVkpo?=
 =?utf-8?B?a1N2S3dDVEVpc09wS2F1UmZRd0p2K3RmVGFvK0pZTlpzT2I3UWpJWnlKVkZu?=
 =?utf-8?B?TW1ZcEtPcW1zNmQ1aE9laGZwQVJlQkJIRkxvOCs2akFNbzlLeGRXSEUvRGhy?=
 =?utf-8?B?di9YOUVOR000Z2pkTnpJNVRadWRPNU1hMGxPSDIvVVA3d2NWaUZnZXBzM3R1?=
 =?utf-8?B?eTBvVlBOSldCK1BXU1gySUZnelJsdlR1QUJDNFZFUXVleUQzMGVaTHlNSGxn?=
 =?utf-8?B?RlZoWmhMajRCYWpQL1BYcVIyblhJZmFPSXR0Vll2dnFMcVplUmVDYzBpR1lV?=
 =?utf-8?B?ZXBoaUx5OWNWS2p6cVVmTEhRRjNqNTJFOW9SVzlrVVhjc2pZRlZ1VFBwR09Z?=
 =?utf-8?B?MEcrVzFQYWxiTzd1WUtZK20xMWltRUZlMFpicGxhMk1HSzNTVnlDSitEbjlM?=
 =?utf-8?B?SWliRklJdElxZGdSNTliK3g5Szc2djFBc2RBS2s5UVNjZzQyd3k4SkNSVW9L?=
 =?utf-8?B?Q0Mra1puc3RvNGJIL1ZBLzh1L0ZEeGpvOVZiYlIzb1JXRDB4ak9TNFQwd2lC?=
 =?utf-8?B?ZVRnS2tWU1IvK3VTRU9ldGNPdUZEVWpob1AzU3pNODJHM1IzVnJKbFhDTGhv?=
 =?utf-8?B?cEtRMzN3OUdDdzdONllaNGtLWnBRcXdJSVlTNUE3VVNzdlMwSkZLR1lOdjRI?=
 =?utf-8?B?YmZueVZTcTJiRld1R3hoaVNJdlJhQUh3QnJ3NTMxTDNtWjhxb1cwU1ByMlIr?=
 =?utf-8?B?NWJXOUg0MVg3a2t4YXpXL1V4VlVKWHFiQzZMS1B2SzNqYzNTclQrUGRRN1lQ?=
 =?utf-8?B?L3pYVkZrSHFSYjdnRGsxUmtYaHdwb2ZPWm95aFordDl3bGFoMFhSZGVrL2g2?=
 =?utf-8?B?Y2ZiNStGU0lFMUpnOFRWMlFKSnZ0SlJzNzdUVkRnOGQ5aVVoTzJSNzlrZysz?=
 =?utf-8?B?aEtiMkRTSkVSSXRQcHpLMVU0QTR1ZW1FZ1BvQT09?=
X-Microsoft-Antispam-Message-Info: XpLOCfl77r+0+yfN9yYJWIaXVVvH6Gr3DicCo22EogcoOF3hj1i6pptfZZ3Ez60BHwXPclwgZ4LAWif4K2F7wRYOIge/2n2ZUf3H3dJxSKb1sjfuqMGD0Ad4UpLeJFIlQOG8JCshR3fG528hzv1jbd+xTSF2Wsh1DsDJpbkdeucAc+IFDwywUbM6Ll6W50Qfkuazw1fwHkKmFA0Qvlg5Nq0isZvxxg0DawF7tMCW3FlsFUpda9d42Gih+EW7yp7LnnabjiNIBXrvsArOApRo8C8/HbNqywKJPn4UVQxnhDrNAAYjVONBJ/IIhUo/YBZpXdoGorh8F6owZs/efFuI1Cmb/UQJgcXU21fV+hpKiwU=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;6:1EwVaOEv7tnu41td9n/fAZPmqCbJtQsTBZmCdfd9fWjpfsenkC+wgF2cTbJcIxVi5EURxhHHE13irDfw4Qelkd8dZt7Zl+20wQEZw+dGZetctxjaX3XGLFglNSCXHtqJ60J/q7iwWCLb94y+jc858XbYxauC10i9S2JEKjJHoUdB+nGu8PlTKL2WJG2IWO0M8cec7zUnrIKmClj8pax+NaOzN7euLjX20skSQbzt8FgUUk0O1STO/76PTYxxAXF9gvw6DQ3NipuOGdV5/M0eZ8lWWA6ZXLCHoipqquBi/vDA8ZIEdLrFX4R+e1VQDbZuwQx33cq/OoHwwgr5ZPe72Juw+85bBjYdc6RpVd/GkACQ5BbNC6mqxDVpGnDk43nfH0LsvjNoEml1DCnkGNLip9glCXUfmc1sLN5biQj7F1znWH5mwO14Foo94vcdEZ3eer7FvLm09v7LvM+Awja7hQ==;5:b3v7wyPU6B+FkGGf0fCIwvWUD4+dJIndCajT861SEBpQ+V7WV2xmjuYv6845oz3FHX8RZB54F92lrGJ4HFKRZ84x5Y/NnojwTGVRyIC2ZadDnPxwIQ4S6gMn7/3NCVbW+t1zgytqRiHyKL/FWbM+UlUW2v3Ip6PWQsFj53rYYyE=;7:YewPoerJVj604BVlW+S8X0gyJzsLiOfia6+Uyl+WlSP2R//Ofcs0BEfp16Jxv6NnLHw7ndtZhp3bdD6Uq1KNwPNxjnXlcdJmVEMSF4F+pjjTqy/PcauxdyNEL8uufNhnJTBcYH+h50CNo6phD3+RnS8ICSTl+caeiz8OOGaV2wAWeglZpukXa9VvwV+dy2+IF1SWCxvbUo+aA6TLg6il+ldVzdwimch8O5ts1atxgvgHrpxKAZVfCcZlpgFr+uU6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;20:frXWr2hksOollMuLwnUiC01XEphvk4XgU+lqRWMtqDks+hNZAtxWGq8hosBuvz/9WRF/413DqAatN31cqCjdT/yUGJjvMtTgbrbxj5crql/1mU5lYJbpyql9eYdlcw1+SmNnDSHQyomcAeyBNNteDObaiRgiSFyEdk4VBDSStpoeNA1EmNwiHKnSjLcnnqzUifdBM5hLqELVSsXLk3GOAsGR+s0AG3geCwlvtiZq7ivwGJjZAiSN1NVNW03a7/Dz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 18:48:56.4269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d546fe-83eb-40a6-6bfd-08d609f23f6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/24/2018 11:24 AM, Sean Christopherson wrote:
> On Fri, Aug 24, 2018 at 10:41:27AM -0500, Brijesh Singh wrote:
>>
>>
>> On 08/23/2018 11:16 AM, Paolo Bonzini wrote:
>>> On 23/08/2018 17:29, Sean Christopherson wrote:
>>>> On Thu, Aug 23, 2018 at 01:26:55PM +0200, Paolo Bonzini wrote:
>>>>> On 22/08/2018 22:11, Brijesh Singh wrote:
>>>>>>
>>>>>> Yes, this is one of approach I have in mind. It will avoid splitting
>>>>>> the larger pages; I am thinking that early in boot code we can lookup
>>>>>> for this special section and decrypt it in-place and probably maps with
>>>>>> C=0. Only downside, it will increase data section footprint a bit
>>>>>> because we need to align this section to PM_SIZE.
>>>>>
>>>>> If you can ensure it doesn't span a PMD, maybe it does not need to be
>>>>> aligned; you could establish a C=0 mapping of the whole 2M around it.
>>>>
>>>> Wouldn't that result in exposing/leaking whatever code/data happened
>>>> to reside on the same 2M page (or corrupting it if the entire page
>>>> isn't decrypted)?  Or are you suggesting that we'd also leave the
>>>> encrypted mapping intact?
>>>
>>> Yes, exactly the latter, because...
>>
>>
>> Hardware does not enforce coherency between the encrypted and
>> unencrypted mapping for the same physical page. So, creating a
>> two mapping of same physical address will lead a possible data
>> corruption.
> 
> But couldn't we avoid corruption by ensuring data accessed via the
> unencrypted mapping is cache line aligned and sized?  The CPU could
> speculatively bring the encrypted version into the cache but it
> should never get into a modified state (barring a software bug, but
> that would be a problem regardless of encryption).
> 

Yes, if we can ensure that accessed are cache line aligned and sized
then we should be fine.

