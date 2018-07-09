Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485ACC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEE420873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nUwBlPE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEE420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbeGIGlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:41:10 -0400
Received: from mail-eopbgr710061.outbound.protection.outlook.com ([40.107.71.61]:35616
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750980AbeGIGlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQuTk+fZyo7ACzdVLmBfvTqTR60zCAJJXNfGhe6otkM=;
 b=nUwBlPE+JlbDTVXAsSArvVSO5iKs004/iuSy07Zg4R7y3ta+LXMo0AKepY9uq5kT4pv/wnBPY9shMkYPedanMRu6pg6P43tAbep5g/b/2hI4I2tXaizQKjJZHQZpupTxW0mv5uu7u0//+tJWAZxWWeyfgWfV6hSf10PO6a0iNh8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.136.128.121] (125.21.194.1) by
 BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:4c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 06:41:02 +0000
Subject: Re: [PATCH] drm/amdgpu/acp: Fix slab-out-of-bounds in mfd_add_device
 in acp_hw_init
To:     Alex Deucher <alexdeucher@gmail.com>,
        "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        jclinton@chromium.org, dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
References: <20180413161601.109431-1-djkurtz@chromium.org>
 <6e46904a-d721-d583-8ab5-82cb07df7934@amd.com>
 <CAGS+omATU0gus_EvbHtegGK1ZkaKVmSOr1E6QLQjd+LA_tC_LA@mail.gmail.com>
 <CADnq5_Nwt+i2Sezh2Rmg9VyYYbc8LAMJyS6eQf9K5yAp-GgAXA@mail.gmail.com>
 <4444b8ea-ba99-902d-cb5b-5cf3f05b4803@amd.com>
 <CADnq5_Me=_g6St_j8fYy20eiZK6fbmdp3zZ9WQMM5S5BuZY6uQ@mail.gmail.com>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <ae639d60-9fc9-04fe-debd-ac1c3be86d16@amd.com>
Date:   Mon, 9 Jul 2018 12:10:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Me=_g6St_j8fYy20eiZK6fbmdp3zZ9WQMM5S5BuZY6uQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: PN1PR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::24)
 To BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbe3dbf6-a5a3-48a0-4755-08d5e566f257
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:TPxmg7AyRYZpw03ukbRYGK0OGJf4y356V8rWGX34IvgzRkFQuStkptaQmFv8GuxDCZ2ARv1+EbvQHRQsLKu+Z5n9jrCRaVqLKwso0pXI4UdEoV8e7Iju5e+hpPycROlyZXmkq8lJawQDcxIXXwkxhmQ3/r7gytb/LVkiP0+XHJLJkNRwz+qn/iBul9gj7PDQRU9pf5hTpsFiTJRi/oFXlg9yE+OkiUQORFmeQhU9cpLVnGsc4NusMsdFAUunzqQv;25:AKsjDH5zR0mwkqgNMWiXOcVYJm/SjO0x0d7kkuWtdSUlOxvJIJLFe8Axsnol3AYxuvCQ2P3BBpv4V0cf1pe73H7rQc9Vaz7zYpe0TKcrds2X1aF+IEgaGhZeZRD9Gdr+i0UqU5suaX4VkFyPLYh0zd+ILJ4t2185Fuk03mRGP7Azgsvuhb9ycp9nXhAIjIIngG4aFfbyaPUqe/ZPwOFrC7U9zu/H0OHe7s242VEFCjOIAp2wn/GRmr7GqX9G0uLpjmbaHlemPYYVl1a2rkbhTH4d32zW1URbfLYOl6Xhz8bvXuvyfFIO5nfS6KxrYUNA/pqM5zpqtsr7O9X7a/5WCQ==;31:+J3xNRctKW1PDhmVXqhl0k/Px+tr+Qkn56Lfs4U9td6yPNnvTUnjGaz6VS96RZp0Vc636jEuXLdXawf1x1uff1pE0b+dBg1i0y//errTRW3FkJ8VzRSWkTqoq/7GL+DHz91nemQGIu5TcxKGcPs61ujnyZKeNmoHpyJ3WGmv/I0FM+5keOSnOSHWi1JsO/qyaUDV21I8jhj0e9J/7oJVVx5Gl6iypL0LSOnLhq72wXo=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:UuZ9N537ajZcLdeacbN3GjLjzL1H1SrD2dUv+cO38w5LP+14JyzKItXWAjDZBX5oRZy1QPu3DBqOP+YxLHCRf7XCBZUCqWnZiRznarmv6Zp4cla6lTpbzZ9GGcrIwzi09kdcBDQspQcpl7+SuOa25tvpGxXB4C02PpFnitFaoYhwpmYLLiMmPbPoZUZHPkK9RZO1qhIvTeeYpyY1inH8jBrTg7Ez/5gUMui4ny0NLZs4yf0P9e85fJ7UeKDlKEDUAQKMew2UharFz9N/CfUVgrlrZr4kcyRriVleo4/3oufK2/U0CDGiJlf5IqY86DO3jl2yoCaqhsy9kMtVa2/LfsUWrTZF07HbQm9MXN+69NsZgpCk198QMIO0YXFVzxmJbP4m6zJ7klNz26HLaORIF1ZSod5b/RuBfX1uMKOrxa9ZozMogzjRC+oAyy2mTdXYhezkaoi1Nu8caTdlvvYuF1WEbw2dNaFND1F6tLCFoZM5ISHqa8r99TiXVy3lcdzJ;4:RY5dC9387X8lqNxOIS174tx0/Kfyj8F6rYLm5pFEIhbYOaxyAU8VD/o6fYs6+C7xgn+LhM/dLGh2qSbmwTTYAHKqCnfsTWrHQz9pzlzsCmTpkfIaMtXPL5QCfKV0VnjrwsA32HGsgY+wXJvzx2q4crUwmWKrnBmPwVxOS1sQ1R4a1QMMBmaxAI4LXt5VfOZpnPTghf1CsmyKJpa3yeV1joXOUCUlhXW1g4dfDeg0Q1NKcxg4KiDhJn4T3/jtRTUNxFQ7ZLDo++dbe5azCVczGQ==
X-Microsoft-Antispam-PRVS: <BL0PR12MB235533B462E481334BBF3F8DF8440@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(65826007)(65806001)(229853002)(106356001)(6666003)(6636002)(66066001)(50466002)(7736002)(305945005)(5660300001)(65956001)(4326008)(36756003)(386003)(105586002)(58126008)(110136005)(478600001)(72206003)(81156014)(81166006)(54906003)(6486002)(316002)(16576012)(8936002)(2906002)(97736004)(23676004)(446003)(47776003)(230700001)(476003)(52146003)(52116002)(6116002)(3846002)(68736007)(2486003)(26005)(64126003)(86362001)(25786009)(3260700006)(31696002)(6246003)(77096007)(39060400002)(16526019)(8676002)(31686004)(53936002)(93886005)(956004)(486006)(76176011)(11346002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:[10.136.128.121];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjEyTUIyMzU1OzIzOjdNKzBtZTNnYlpCMDI5R0JXZGU1RlBPdHN0?=
 =?utf-8?B?MldabFc5Z205N1VqdnNpd1EvUWN0UktNY2dwQmgwTEtudDZsMzRPaHBEc0d5?=
 =?utf-8?B?NjNoYU9wWm54dElUTnhkbmVXWk9ObGNYdDUrdGVBZnk1enF6ZGhGNmJ1Wjkr?=
 =?utf-8?B?MTZDeWMxeHZGS0RnZ25zeGRxZVppK1JCQTlWYU1EaDIwRS9tM0Q1UHZMNzg5?=
 =?utf-8?B?Y2JQM2ErVmdpaGRjb2RrVWdPcDVpOVJzeUFSSmdOQU9sbi9zczZtVlZRQTNx?=
 =?utf-8?B?ZXI1NWN1T0t4aXhZME8vU1hZRDF2VXdNM1dBall4ams3Q3hHVVVCVENwSWVj?=
 =?utf-8?B?N1VpZjNENmRTZEg2OWo0SGZDTlRtam8wZzY2L2t6aC9DVUJwSEY3WDNibEM4?=
 =?utf-8?B?QlBWazVteU5vK0R6YXAzSzFweit1d3djVTNJeU5oYVRzVER6aTR1N0IrWlJh?=
 =?utf-8?B?MVhTSTl2WUhoZUh5WGlhZmNRSER5SUY2ZGFaTTliWFRTNUIyL2d4Z2dQL0p3?=
 =?utf-8?B?aHhSNE5kZlFMOUp6Tkx6Ung2dmVWK1BzY010RGJxUkdCM21Ea1E4cmVnUXd0?=
 =?utf-8?B?TUl1eFRnc1I1aWVjek9OVERqMWI4NlJIMGRkV3d6dkN3MHNSUVFQTjZIeUlS?=
 =?utf-8?B?dEdGYzBpVFB3U3hmaTBIUFNPeGgxTGcrWlBWZmMrV0lDRHNaZVNmOXV4ZzBs?=
 =?utf-8?B?MXUxTVQ1dTY1MHFiS1pXaXJCYkpCMkZOMDNRd3BnWWova1Azc3JwaGQ3Q1J4?=
 =?utf-8?B?MnRKUzBoRkJFemdCVmRyMnUwdkxpSXhKbUVvL3JhVU5yR2ZiVkhndHkrYXZX?=
 =?utf-8?B?YjMyS0VOdWpQWCs4ajRvQUJReUd1SS9mamZVbEgxZ1pWb2Q1QmpXb2hDNmtX?=
 =?utf-8?B?cTRHMXltVFdjZ1J6TzFrb0lmb2d6U05GSW45bm9xM0pxU1F1b25IT2tFQ2lT?=
 =?utf-8?B?Mmt4aytST2tmTUFvMDN0MUZyQ3U0Rit2MTNtSzBCNmJHbkt3cDhRcGY4eTZS?=
 =?utf-8?B?QnV0eEZyUGlTT2xwc3pDa2lJKytkajFIMmlNdkQvalB3WlY3Y2Z0K0hDSWFU?=
 =?utf-8?B?MC9pR0ZoM3REWkNwNk5pUjRHWUQyNjBuZWQ1bG04VVZQM1lLL05uNm5KMWo1?=
 =?utf-8?B?L21tRGpRRFExcVVnSm43dnlpYk1nSmtZdklBaFJObWxjUjF2OUwvK2Fpbi9p?=
 =?utf-8?B?eTVRT0YzbmJpWVA5c0Vja3FlOU5iVncxa1VnTk5MMlpOMGp2MTIyclQ3d3U0?=
 =?utf-8?B?KzFvcG4vQ0JUVVV5MDk1VU5mK3gxdURhNkdUSWRvY0dlcGYvblhHREpIcUJR?=
 =?utf-8?B?b0lMejFVTnlCYnFUV2tYcnJBL2hCTENMNjlOZTdCNnlCUzE4SS9PL28yU0Jn?=
 =?utf-8?B?SVAzR08vWHBucTFjWVVRT04xMFRJbnM0ZS9pQ1Z4alNoeVhmOVEwWThWZU5O?=
 =?utf-8?B?bUxkM1hyODdaOEM3TllxS1N5UmhNMExPNzM1aXhURENWTjVUTDFZUHZQbDl3?=
 =?utf-8?B?MmhxMEVFVm4xTVR6VXpmTTZwWDU1U0hqRmtkczBDVnRzYm1FT3ordTV6Rnlw?=
 =?utf-8?B?ZWN4SlNOUVB1bGlDUGd0YVczSVRWNTZtcDZCaE5OcE9QL2lHa0xxc0YvOTd3?=
 =?utf-8?B?dzY1R2lGVitpQ21FeVlac29WcG15bXJIdzMxZ0xJODRyclNMRmU1bnFpREJX?=
 =?utf-8?B?Yld4Wmxtdm41cVh6ZThicnVZSHB2QWppMzZHYnVUTyt6MTc1RzNVTE4rMWxa?=
 =?utf-8?B?QXl6TVB1cUVIR1NwUEtiekhZRktaL3NvcE9JZFNFaGsxQXJweERqS2RVNnU5?=
 =?utf-8?B?R3piLyt4NGRSVTFHQmVsQ3hUYzN1dG1hTXZiSjBGOVhUbFF0S0E3Nlh6K0Iz?=
 =?utf-8?B?NGtycDNJNjBFR0xvUjM3U21LRFY5WnF3VE5SK0tFYitVWHgwa01sU0Zoa3Nn?=
 =?utf-8?B?alRKMExWOHVvSGw5Qy9kVmFnOGdNdXFjUWx3Zk0rQTh3SG5MQVlNa0xyZFdK?=
 =?utf-8?B?eG5XQWdOS2QzS2hJYUFQNCtLOS9jKzBiUFVoQm5NMVlYdVRGUkZLclFHTmN5?=
 =?utf-8?Q?SRvg=3D?=
X-Microsoft-Antispam-Message-Info: iJc2nFc1Bq+FzjqamArOwvKf/+0aLaioVxJjGKNf35azxFsmoEfGMkYr2kteItgOvHONDQeXG98VloImwHQkfO3dW39oNqsm+4bGz2GI+83WssSDg0Gg4UFPpLxpYXq1U6LbF+muGSjY9/qJahd5vrzJPfM/fVyD/2xLoUiDJ79JcdXD/None2VXmtNx/INgmOr5F68nXfFz/lan0+mqp7UpRQOVuDhS46wjjlUoiaJteGI91fjseBURyQG9zbTFPPQry8xS22QNtjeqy36MCf5sd0ow4uLzMv0WcRh/+lEFOn11Yg/c+hjvEdL2MyenP84oATfXfPLURmNBemcSBfIJNxabM3Y5H5r9AQn+KK0=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:yy6FwcdQLQpI6dX6RgKsjI+bjQvECRbHMcUCnN+EixBzpyqkVNB4qndX57KskqBmWK8C9t/7NUnD36tphoLl8iJH0+Wi5pH2HxDy/WZ8S2fcFRqQG02TD8lq2xA3pQgznatTFMltv/aQx2tR5NLliv4wz/zcEsL9Xq28aw8YAP0Usdxntk5sBwONhubCTTnVykpyFqhG5StQZyMAx0081I/XB09M5ScoGS9C5jeRwcTOgN5blMUuQ7M2CpuZsPmxNRfhw7maP7GJk8vemU1qHPtWz9BfVreEeCUHWQd5Y0XgcpH8Gq1VaHZ17Ta4uNekfBKWjfHUgVmLYny7HaVvsqHfEk2HFC+kWSVpHG7BvPzOVFIzb5n5Bkx3jmd8yAU9DYJJQ2sJI9Q3YyWRvp3uotNTEB3RyG9aYene0XcMmF8tbdPKXHuVkUw1bOUCJwIusoYi1825Dws3YxGL43nGRw==;5:ZFc0S7jZrt9Ki/WBmzzZe8O5p+ZavzqPJId5ZQbOxMpeAmjXySROr//fHHS1+iePWtXu4jWloiFVgG+2zRIVwu+ZAGQK397oRKeYcxEUcD2Mx0Jm4qjBNgxCN4jbQ4AcAK3ZUfmSO3rAD8L4z7gfGLwdm9dHZAa15rjadtfiWsg=;24:hgZUt4cPVBgc0SfcN5gUsrRAMbiyrhOOeF1oWVA4Q2xYP+jX2Imo7B9dcHUxxu5xNS+F9NlRkv9Hwl1qlDtCFPBVaM8bnlbXXzlkbua/z3g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;7:plLVBj17y9DSyQ0zIBtoKY0puRdkRYy5dK0CGz414faJW0fmkcxu4zxIlJaccFtXH2XfKUvAfYpmn8NzDQuRdliXpWN5nhxntqN35mxliR5bZq652xHL7ZdMyHmzeeaPuq672T/Ow/J3/8BtJoEBLvZNSVaIhGVnOaxOzF7r6hWNdDM+IJQ4N5YbVuhRLGsYBfHbGYUURX3Dgy+lnux1DsQOTvaHRzF5w7DqEXBNKujKePQ3rRnOu5EjhR8mwId9;20:IPLKYo/dfsisvUUYR1Xzps2Kvy8ni6kQ6Z3V62SJSvv7L1E6JuCxWKdwTlbLzdBPK0Oq94lljwGrB82uqQIfkYS0oJDC+6Mot8hPWeL45+R3QM8Kcnhzqdk7KKHiFfdJVtN9zDPRjTXZyedgX9h26VTCCBbuhTIxZh30nRdtm50XKdcCnnYRCZ/eTWBuR2uixca5IEc3Gixg3PYydKiVM4V314IGK6NzLOioQV8malZ7VfiSUpo2bEUfpVPqpOBT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 06:41:02.6061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe3dbf6-a5a3-48a0-4755-08d5e566f257
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Was this patch ever picked up?  I can't find it in agd5f/linux.
>>>
>>>
>>> It wasn't applied.  I don't see 51f7415039d4 ("drm/amd/amdgpu:
>>> creating two I2S instances for stoney/cz") upstream yet either.
>>> Daniel, Vijendar, which ones do you want applied?  Can you send me the
>>> patches?
>>>
>>> Alex
>>
>>
>> Hi Alex,
>>
>> "drm/amd/amdgpu: creating two I2S instances for stoney/cz" patch exists in
>> drm-next branch. Please pick the patch .
> 
> So just that one?  I seem to recall there being later revisions of
> that patch that you reworked after applying the original version.
> Also that patch was originally part of a larger series.  Are those
> changes required too?
> 
> Alex
> 

Hi Alex,

In agd5f/linux, branch "amd-staging-drm-next",
506f7d1 drm/amd/amdgpu: creating two I2S instances for stoney/cz
patch is present.
This patch is the correct version and there aren't any other changes
required with it.

Only Dan's, this mail's patch is currently missing form the tree.

Thanks,
Akshu
