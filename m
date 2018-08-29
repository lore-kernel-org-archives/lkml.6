Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6155205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WkNq9K5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6155205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeH2XFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:05:05 -0400
Received: from mail-co1nam03on0057.outbound.protection.outlook.com ([104.47.40.57]:30785
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbeH2XFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nP/RD+3GcTPVll1fYlDYMgWrK4Z39naYwthdCEWb4A=;
 b=WkNq9K5X6yBsf/DurKUkhGlbO/5vPsayVde3/BtGeTM1KRcfYEw4CnzWl2oXZp6pkMPvkAqsfrcg9XYHa9ZlqjAJgqkT8e7ANI0mRNBeLMWtRsco44yxMfCoA5XjlQElSOmPocMub9NNDv5r0z4oV98viD7ZoZntwxIOf5iMrvM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.18.82] (165.204.77.1) by
 CY1PR12MB0168.namprd12.prod.outlook.com (2a01:111:e400:50f6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 19:06:43 +0000
Subject: Re: [PATCH v3 0/4] x86: Fix SEV guest regression
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1535567040-1370-1-git-send-email-brijesh.singh@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBfwQTAQIAKQUCVo1liQIbIwUJCWYBgAcL
 CQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEN7/muRPME1TTfQP/A8U028LCMsxhCmg8KnL
 oaXk5iRhiS8bhQILSWS0wTGjnpyYIsOdL4TwLLMfFkCtSjsdQSOnu8RVP3nu1waC/6U2pWWS
 W26B4GwpHfq/mi/PZOBW6+tt0srwxVvuFNVN/uE5r7Girlc8QHQfNyYxZu4eTbl7MuIIwuys
 rCueJGgaDOGps7aeknQhSYIBsdV2CazuEa2T7v4KTsjNbHCesayUbl87tZoBcs5Cf1yeUjK6
 ePSVZPszEQ9Z5iE7meU3+COIQZPvEhaYDx5qpHZjakWpb0AfOspIxgxRR3W+sutOKshbdNDy
 IhbYc9xDjOWooI+6lkNKIdAyqoqq387JndjUuXVYPM3lNY5MVprH8bO1CUzusuMFSB8SlMKq
 p2sUEiS3jBpSd5C3GKxYAOkhTZn1kyNB7CyBVU2R4II1R0aSJf2yxOmWrEboeFO/SZQAX5ji
 A7obQE44zVZlSIlFh/sm7ns2zxJYyafML5N9CA+5RWJ2QQUzzjgZkvTc2lBwvl+kAe5P23aS
 aWbJdEgjV6jwhzHfKtlIznqk/t0quVwEzhzfvzxK/8HL+di2aeg5YxPA7VrjDRLFRGiCUgV9
 gAPlLR92LnUM3XUgdtCAlQ0xPY1qaxbqZcK04zGQu6HtcO7czIwLf5K/pjwQRlMxPIUDFcTx
 gl81owVskfEp6Y76zsFNBFaNZYkBEAC+8m2NNYbxIOqTodhtUPv2VpsoovMYUNLD47xF1m+T
 FryIe0cQ/VeWb9eOBLWyAAbUdE8LO8Qzm3u226/Z5UsWT7q/iQ7BZrcsIJHe+/BtJw7d4u7M
 6s3EDznEdN1O1zw0wSVw6TcFVfi/Mb8eYLK9iG4YgUHfYl/JGqeZNyOsHwUmZtWYFhkG9pm4
 rqjgz838zXSq/zArcVhLFjgH/wpRXMq/nPxIdvoF4AuSnodmSG/8TvtQq0wt0oPZfR7OQxtw
 qZQm1Slpmi9cu5nQokrdm/3VxNCtZyUfWckRjpX8GcNWhTx0/gMuaeq2Rs2nb7u8qQaE8Ket
 kdaOOeo7OwsiIPNTutaI4g1y1BsWTfwRGDQwvZ/atT8nzKw+Ni7bzj+mUbQXkjxB+Rv+aSLe
 BVYrdGOME66Ru5owTNOpB3elfqX5QfBkcU6uTO5syxYyC1JffwSY82Ac3rLKW3qE/xu3uSam
 4i1lxWDnoOlyf4jgjC3XfUS+OiV2CbAWZ42Q/EZ+ilTu6arOSfSv5yQ1cgnX/CZ2A+Uaujjp
 oD/8w520lEjmVqx0FkPL9xH+uuY6aFzavmcqG6X23ooblnwYaa1lJND/5vnJ0dqnhOMl2JeK
 gnFgJEchkbts4CMFwDlwh06svU1tdCxqtftOPi5iR8KQAAUi7a+yYIeHq1l4vZhaEQARAQAB
 wsFlBBgBAgAPBQJWjWWJAhsMBQkJZgGAAAoJEN7/muRPME1ToGMQAN5eR7zVdNCRfNsY8bcw
 xqwTgBu5sugTBghHPRLfQGZOBBg/49iu/6qDu6Q/IBIXc1963GOtd0eOD1fjdtgNzP6WTvZY
 6zzkNvcwZQpWBTlXJa2KqKzdqGyTPZSj0YlY23L461PelTuxdIxNv45pOk32yg83NTqhxBZu
 mlAuPCfFpyH4IEEEB0j+9WEZnzl9cBLzw3rVv9bEIixe5ykSmG8UHJ6FJ6cI2myru6uwzbOu
 n8DkNLspmZppoTpwzPCY/6iljBLUBzDDRD8rzEavva2IhzINkrAvNSW6VpBMSpUBgsEIKxrp
 AFS1ax5uXmwYGyFzOWy034Zz5fWi260qiFplzKCij8t7sCgzOXwEbIt76L1basrRMY7urJm8
 4VM6MeG2mfa92FfrMeL0pnD5ONg1FIuleGlvvKdQdFnE4AlwGcKid5GUD+vNNj/pbZyUpe4r
 zBFsc21/8jXSlR6zJS4mgkNDIIBGiPny3tvKINMZ8VK00mR6INpd+NErd2LxwZ/DQ5ejVyVL
 080CbiD55mxxhqkbd5fHSfdhvvXIIYN+nM/RFLwaQGW9g62iFWlqeNRXezkERDV5ahFqZMP4
 YDdodn0nRVZYu2kaXfOclKPcH58HlrRb8pKTE3t/TNKGY3SmKoznH0QtM27TWeZ9R9RgTYiV
 zSNqP+QUNp6BotWI
Message-ID: <027f1fc5-07a1-1150-84a8-822eac9c6504@amd.com>
Date:   Wed, 29 Aug 2018 14:06:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1535567040-1370-1-git-send-email-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR0101CA0026.prod.exchangelabs.com
 (2603:10b6:910:3c::39) To CY1PR12MB0168.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c1469a-36f7-4677-911d-08d60de28f87
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0168;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;3:pYGzOc+u61LIuXjUBMYWmqcRK8XV9JnZ4gXgrOH91GrvIHOBwoTlraIA3IieEEZBK1z/hKZsIyKRa+Iw43wxfOqQPYEysNqO/5WHkuLs63330jCiBHgIGkgce8WdVp29t9U4RncJbF5QIy45Emfk5zRbcnQG/TIFwJrrdL/pO+cYxDlwzaeqOo4ZQ0Ix56UZkcSReZRqjnA2pbZUdIoYhYDZ8nzLdH37WasboCwZZKE/TpgQQ27FAqPKVjHNYbG4;25:pI0vQfglNKmbF4lUn/gZDLhlg32oOWDn9gPoqMvQgega290BCwKk2teVIYJEWvqUKAW6Vek53i1mePAGoh4M/hPAMh7uticE0ph1zdNprAt+CO1N8pK8iv4KWj8vOG3/4WPvYLchEVOtOVf3J7YAThcWdUK22xU+aeA6ypRoYSuE6RQywAqLPj0zWfQDWsaqdQBicvFqBW64+9wf3Fzd6+5wy6SlWCozuYcnXPZ2V2ywAzetJQhGWoJXl4PEd/xbR9pjMbgovzpJeVLxwUxIZnBssFDxtbjMQJsJADD2WgkZW7bK/UslFDeAiU2IZj/e+6lenbi/4z9S/vQzQl5CgQ==;31:KFss5GAAuS5n71R9FhLIzBs5Aic0FyJHlQ+cxgL7MmbOT6VLJmmq7x0l1QJbK7qhEKLHoZkhe4CALs+FWJo93apgntGBLxKNy5yH0VwJDnjXqe8U2xowRB+1etgvObjBOxV+6v2HFjjTSNisyS82EvjoxTljE3fpBDCcNIsYiH/AN5th01TDS22/wI8385CNvpUh1O/Q3eVlqxyE6CdGmvTPk5pkrDGgX6gcxWKznVo=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0168:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;20:tXf9ssgyoAxpNEZWEJAN0H4nbwsVDKeYqlhhIM6shWCU1GS2oZwNmeQDIHfbxCFbg/uvjMSKbVtxxDsmIEgRcc9T31LmARd0wq0jcQAySMNdrfPurFxUEwqh/ajfb+iHXt2mb5wY7Ye7f6WjYUBkeDcltgaNr6X2ScxTkNqfiC17lIh8SiI+amuu2xPyK/+PswI5Xdu0twdjDal1Zx07A5xWNaAagC4HC+8q7VVYznK9yJRcn7fH6VlU3L8WZwa+mB3axma5eedp6W2sDVyayPia2AMwYaLoIpFqaSK2uh9sYFT0ER/e/xOVm5pJmewVvmg2kIWoDDEFAdssuwI0rywVe9fFpV4O3wTeK8500gac2qFwdZwImzys13IPf/PSI2jzNAqQw74PZcn743dLu1o/6LI4gFJN6OCxU5Y/CIVH9NZqH41sa6O8PQQHR5bnfNUPFuDHOJLMppn7uhrjJfILp0TPivoCBJUCzbCKNCkU0Q2+MFzrRQUaMGgNteuy;4:+hiUPyONPhMkDuhDsXetl5jYN4+8BkNfqBqZPSr0OsBW9ZfQUVWKpYPqHbRH2hroGrtVebdDTB4gwdwXsKfM04fKVH1bhPcYJw3WliuiZybsTZwx+deAOy/7onByeRncQv720NtoybHMjCv/zH+DBHdLgY5NQLFP4sQffieRWhTa/qk16ArQ2kALXEUH5B1M0ok4koMw0kEaJEVRAeAFGNDB2GHZQig5kXjEOVKzflRwTilBjrTHI+qLR+P9i3Qp/1f1bf6Esr1Nzni5dXaiMbfGhwIWFO89nC0D9Zf6Ofdy4+ZMwrO/fbDH++OwaKsM37iC7Nm/bxcXGAR8CPCd4KeUNxa8llQQ54Dffk3PkkXGDgldKgA18Nagps4LIczd
X-Microsoft-Antispam-PRVS: <CY1PR12MB0168B52B7BCFDD6B3EA12CC5EC090@CY1PR12MB0168.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(84791874153150)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR12MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0168;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(376002)(396003)(136003)(366004)(189003)(199004)(106356001)(6246003)(14444005)(64126003)(65826007)(72206003)(25786009)(478600001)(65806001)(966005)(956004)(476003)(2616005)(11346002)(486006)(86362001)(36756003)(8936002)(66066001)(4326008)(47776003)(65956001)(446003)(53936002)(81166006)(31686004)(54906003)(6486002)(58126008)(23676004)(229853002)(50466002)(8676002)(2906002)(105586002)(3846002)(6306002)(305945005)(97736004)(53546011)(386003)(6116002)(26005)(186003)(68736007)(2870700001)(52146003)(5660300001)(2486003)(316002)(16526019)(76176011)(81156014)(52116002)(16576012)(31696002)(7736002)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0168;H:[10.236.18.82];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY4OzIzOm45eGEwSFhacjRlYzdpWWVXRWZPMEZvRmdR?=
 =?utf-8?B?ZEw0ejdBdzMxMDFrMlUrS2JjQUxJUXNpb1Q2TkorOVdVd3pCT2hjakxOb3da?=
 =?utf-8?B?VCtDRGpVdW9kK0RiclV4Y1RyWGN5VTN4RE1IQlNSSGM0WHcxOGNNSm9sanEy?=
 =?utf-8?B?THJDUU1BTExwWDZaWWxSS0FkU29wZTBnR2FTUzlPT2RESTJNa0Q4WWJ6eXFa?=
 =?utf-8?B?d1d6SU1ock5mU0wxNlRRRENlTDBvMFVYbTN2aVJsRUtTdG5nNEc5K2JkOGc4?=
 =?utf-8?B?cXpFMXdNRWh6QVc5VzhIc2p2UFdZaVZjVFZySnFteGZFTEo5NTdTdVpvajV3?=
 =?utf-8?B?M3pWK08zUWJaUDJQYmhVMG9BZ3hQbFBJRXBLUm5qM2d0ZGttU0cyNXEvVDVB?=
 =?utf-8?B?djExejl1eWU1cGc1b3pHSVRBOHhndFNkMUZiMmVFcUVaNkxiVjd5WHR6YWls?=
 =?utf-8?B?Y2toUkJaSHc2MWVSeFFYKyt0TVBoZU9QUlFUdnVXK2srTlQrcVNNZkVLUnBE?=
 =?utf-8?B?TzN1MFRyNVNtaXdYY3FIZzhEYXV5cnpxZ3p1Q3dqZGtheXR0Mk5vaXZncjVK?=
 =?utf-8?B?MndFM2FUN09tQU40OWhUYmtHSTNEK2d3bDZOck9TL2tpTnAyb3l3Zy85aUdO?=
 =?utf-8?B?TmQrMGlMNm9LbTVyaVpoS2t4YXF2VFVUMHdLNm16VVpYYy9SM3htR0JRTGM1?=
 =?utf-8?B?S0NrMUVBNHovUmlsS3YxZUVPZDFkUHBBVFFLT0tKY3JTNGZFdVJmaVRGTTJk?=
 =?utf-8?B?NHpqVlBsWnpzbjRjRHBQRmNGZ3FEYVdjTjlSZkRHTnBvSERJV2ZoNUJzdHFE?=
 =?utf-8?B?TmNLVXdZZGhENVJ2bFhDN2JiOTNPZGNyN08zTldqMUJsamZxUTUzaVRwMElz?=
 =?utf-8?B?TXpYZG5HeTUxa05TRXVSLzFTM0FLRjBMUWVTcnZpUTdCNlNyU3kyTTNoa0RZ?=
 =?utf-8?B?cEwzbTNCbG1jVUN1TlBLRFY4akEwZy9sVll2VnFuUFVXRGRZMldLNEswN2JJ?=
 =?utf-8?B?T1VjRVpBZjcyaExsS01nWFkzV1llUW1BTGdFbGlhcDlja1VYRFBiMTZpcUxx?=
 =?utf-8?B?T0U0R0s3ZzF0YXZUOXI3VUZpYUxQYlhKa1Zua2Z4VXpjcFJ3Z0NrQkJnZ2hm?=
 =?utf-8?B?a3pPZWI2U1ZxOGlwbklVZ1M4ZklDWndCR2lqbXo0blRNT2g3bHVvelVoOXMx?=
 =?utf-8?B?MnJFcnd1aDBSRVRjdDNGSGlPditFYWkvd2xVTGhrU2tRNW5Na2gxQ0RtQlY5?=
 =?utf-8?B?dEZpSmd5SU1jeiticE1rcC9BSTRVLzNCUCtmSURBNmxZdzFDNnoyTFBiTHBu?=
 =?utf-8?B?dFNiZXFnM2gzaGdlTjV3WERtVjJRSTJUY0tLMDF5WTVFak1vR250eEh5R3NC?=
 =?utf-8?B?aWhWTVZOK0l3TC9kcWZydXcxSkZJME1SWEhxamtZUEkyT3ZtTXc3eUxDaWda?=
 =?utf-8?B?WDdoV3ZIQ2ROZVNab1lnWWFmM2ptZFcyZyt5ZHhQTWNhS1FyZE9JR2FiUWZx?=
 =?utf-8?B?NkJOUmdFSFNoTXpibEdmVUZua0lZM1JYeGNoUmxFd29NTXEwelV4bThwczJk?=
 =?utf-8?B?V1RidmRlYjFtUmtWRUN5YXU0VWNhM1NSVzh1MjN5VzNYMGZBd2tnOW5iK0hC?=
 =?utf-8?B?RURJVVJsMExBVm44MDF3VzdRMzNwSk9oc0Q4V20vNDFNYXZjUFlrTWRUVUtr?=
 =?utf-8?B?S1ZUUHloUDYvaXU0S096RkVHRHQ1VFlHYWEyV0lmN283SllPcG0wZUdsSnhC?=
 =?utf-8?B?OEswRUl1ZVZtNnRyZW1WRnZSMWE5VXgzZjBnTDVUajk4OGt6VjBDTEJPYVda?=
 =?utf-8?B?MUNSVHZrRkRLbHB5WFQvNTRwUUJranpDRVZSUTIxbG10ZWNRNkE2TkErakNx?=
 =?utf-8?B?eGVyb0U0UDh5SjdhUEpwVVZkQVdEanhJSW5CUFVKTVVUYmtiQy9JcnE3VE5J?=
 =?utf-8?B?TWU4QVdvNkRaRW1OanJUdFdDWWFoaEdTQVJkZ1k3VEJjUHJHVkppNjc4NUVZ?=
 =?utf-8?Q?18ObUF?=
X-Microsoft-Antispam-Message-Info: g8lIy7LuLeKeNGSkkAaAnbu7dtJRbM/Ir/GFN2L98S4+oGvu+I+jBE1kT3QzcvWJmQcjxJKD244nQVx8rUTp9kaP06fyADF7J+Y8exrkxqq1w95EdxocJb43sIivfmXZlcOy/nX3ZtbXsQdvt4cGyLlc/Cpn1QIox5LcKgb9hJlNKQnP2po7yB+4xKNICzQ7M300bWWMagRlLUMUP1kHfaaI63Yyx/vyc0FNkArH3eYdzkPDKmmoopLg89YSKEydbfSdMCKF0lyjSKnKzxQE2jg4JCNKLSqZ3/x0x272S7A+beZqUWzNVh3gp2s5Uah/dwNfd4+tb932h52kg5ogSvOsS2LFKH5nlHwdiwFCJg4=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;6:zJq0fMp81GX0N7nzDZleIneODQxQ0p+RhJrHhPsdIQ6NtR6d7nvRUQ0uvSvur/pMdHk9o0rLMBYE7ATVq2OVmPL6Nv2l/NyQeCbovnjDmZYv2QdPeB4lOp3wigHFgT9CuZnijYNK29HLIskleSTfzX3eWMkhCpC09UmRgFw0zkQQP9dmEa32w6ldcQKQbiHMo+y2VSzI1rNvldHkQVV6ueCG+Z09/mE8hmKQMDj/oLfOMVQoLj56YG84U39JUYp0wWcUKISyqtqbSYHWh3SQOZG43hDyeiXQw+wPv4RTCprx2oK62/jhcBdDLjWkZJXFhG0g6I83aJRImkAo20RCPgZtAH7PZ6iKJfhAPbmps7BUpleXvI9Ef/XDwqY8MwFlsGH8zFt/inYitBImQgqB+mh97sDt2WYxNE+IdXDr8XJOGNUtHD5UlAZkwULp73yrjmpPox7nQ3xEPH6PY/zC/Q==;5:HGbiTsFeGTJEwixdFtZtdcRSpmr01bcXlrH0K1I+L6zD+qiwPbGwcAQGDxrWoa8oUH038ya+OlOQQtKWe60CJ6gvO3r989qX99gTQFVN9PaBX1mkDUx0ClZR1r/qm4EMXdpM+xXoC4GNQxRdk6e3NNvUpIEK1q8EjKsNVDfpDO8=;7:uCdGvyw6EeQonnpB2T7zmquYXR2uh+wvgLlXvVuIOXMNuvohR5YZ42alvli6n9VD4GTbvnRB2lLHS+K4dG6N07d5SRHQZiIpUBH8zJV3XWx7u6zZ/0ZY3vJbS2nopQrgSuIg1xUkhxOKcuxTwBX7ng7oShaJsxerittvmWaanWKNH97RBKHwWIAfciqxPE5U3nEURYo19E5LAheoLmeNrpkzmxTn4yBqM7ney4ZgzUtO95RFFGzPExzOL/wz23oc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;20:zVyTkhbZTJ8YaCA6pV73HddxFEMNsBDx6whsFmi9tRQ+II8y4q32RW1YSo57qtyRctVZi7YwZGFl5h/hcdvFVrz9Rs6L4msZ/Z0DWRWFiDvXn0lJHSrF6hM6sZMh7NRm1aK2Lb7GAe8BEvsM4saoQOqw1wDD4CBC4TbEVTnxHA8DiOowHn36KHPb5sUBysfKlp1tXebb2Tj1g24nvXPNE/0UOmvehN2lsJ4FjnkSwHB0EHjpjp+WlnlacBDupyU8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 19:06:43.6666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c1469a-36f7-4677-911d-08d60de28f87
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 01:23 PM, Brijesh Singh wrote:
> The following commit
> 
> "
> x86/kvmclock: Remove memblock dependency
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=368a540e0232ad446931f5a4e8a5e06f69f21343
> "
> 
> introduced SEV guest regression.
> 
> The guest physical address holding the wall_clock and hv_clock_boot
> are shared with the hypervisor must be mapped with C=0 when SEV
> is active. To clear the C-bit we use  kernel_physical_mapping_init() to
> split the large pages. The above commit moved the kvmclock initialization
> very early and kernel_physical_mapping_init() fails to allocate memory
> while spliting the large page.
> 
> To solve it, we add a special .data..decrypted section, this section can be
> used to hold the shared variables. Early boot code maps this section with
> C=0. The section is pmd aligned and sized to avoid the need to split the pages.
> Caller can use __decrypted attribute to add the variables in .data..decrypted
> section. 
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> 

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> Changes since v2:
>  - commit message and code comment improvements (based on Boris feedback)
>  - move sme_populate_pgd fixes in new patch.
>  - drop stable Cc - will submit to stable after patch is upstreamed.
> 
> Changes since v1:
>  - move the logic to re-arrange mapping in new patch
>  - move the definition of __start_data_* in mem_encrypt.h
>  - map the workarea buffer as encrypted when SEV is enabled
>  - enhance the sme_populate_pgd to update the pte/pmd flags when mapping exist
> 
> Brijesh Singh (4):
>   x86/mm: Restructure sme_encrypt_kernel()
>   x86/mm: fix sme_populate_pgd() to update page flags
>   x86/mm: add .data..decrypted section to hold shared variables
>   x86/kvm: use __decrypted attribute in shared variables
> 
>  arch/x86/include/asm/mem_encrypt.h |   6 +
>  arch/x86/kernel/head64.c           |  11 ++
>  arch/x86/kernel/kvmclock.c         |  30 ++++-
>  arch/x86/kernel/vmlinux.lds.S      |  17 +++
>  arch/x86/mm/mem_encrypt_identity.c | 232 +++++++++++++++++++++++++++----------
>  5 files changed, 229 insertions(+), 67 deletions(-)
> 
