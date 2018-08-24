Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403F5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F5621564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rdx+igIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F5621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeHXRTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:19:17 -0400
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:29610
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbeHXRTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtGQ22oUCx8VlsFrB15rOlNgv/4+AZvVyAxsPCs0Cns=;
 b=Rdx+igItctvBBAGquzHZD9u/qtPTCTqFj/PawQm/N+3oAAcA9+QOWQMKKVDLLlCbjbpYwgc6RpX+4sqvbfIgV4Vnlxdu4xAB7ZizWA51lCYyvkIgqTYPENVesfLUDLrffzSLGGsmPWirl6LX+RLvKt/mmurjT0KZNM9Jqd9Fji4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:112::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Fri, 24 Aug 2018 13:44:17 +0000
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
        Leon Romanovsky <leonro@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180824115226.GK29735@dhcp22.suse.cz>
 <a27ad1a3-34bd-6b7d-fd09-7737ec3c888d@gmail.com>
 <20180824120339.GL29735@dhcp22.suse.cz>
 <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
 <20180824123341.GN29735@dhcp22.suse.cz>
 <b11df415-baf8-0a41-3c16-60dfe8d32bd3@amd.com>
 <20180824130132.GP29735@dhcp22.suse.cz>
 <23d071d2-82e4-9b78-1000-be44db5f6523@gmail.com>
 <20180824132442.GQ29735@dhcp22.suse.cz>
 <86bd94d5-0ce8-c67f-07a5-ca9ebf399cdd@gmail.com>
 <20180824134009.GS29735@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <735b0a53-5237-8827-d20e-e57fa24d798f@amd.com>
Date:   Fri, 24 Aug 2018 15:44:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824134009.GS29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR09CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::27) To MWHPR12MB1726.namprd12.prod.outlook.com
 (2603:10b6:300:112::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79243db5-5a51-4a6e-c1d6-08d609c7b4fc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1726;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;3:SHSQzbl8sRXP+/N98py3zEfKGPyDKpnRzPuOyTjG2E3oIBNdnXtIOBJR0yCIejw3j7WeqhqDLCmsECEeZ4x+bFuFei1CHT00ytBYXDwbEwwx9xr3uPXABmikoYk0HkY5rw4MSDK64H4UFcomuUjUP0zjn2rVMgdpYFIpMAuHTnZ2dhPlLk0ImSQt6A+/x4/fwSRo+lHSa3W2+tOi5H7qj37N16aK9PxsMiRO1uC/UasGUHbyGZQTIbdXYAYBNiCR;25:ByZmfNq7DMkJ7qQkXD1lOWxYvVcrH/5QZQyTdRh3Af8riFCpNnMJ2w0//BWGQiA+KOWEy+EU3P8Cpx5G2M0HdMUEKuHnB7dOTh2gXO1nSORBD5B9sNWpj/uCmQleQM6ytxhhlxobzCqzrP7dz+aw+uEPvH1vB7xXnPHpgHlgPX/F0UxpZZwT+btbV1iYjS+OWRNQw/bVDMQcbJAIwDsZew4nEAm6wSWlFh3QbQ08+pPExm6Tcf2Eq1aTfT/tb7j/CXFDA8lFVzUZ7KTYUqoFQxEjWl7dG4ijbFvIumKfqmGoiK3Z+F1Nsh74MAuY0pF2ZA8+iplULvcibyQg6py8ng==;31:9uzDpKythV35TwxlxYkc0y/Vmul1J+mP1ut1CF4Ut0u/KsqO0vk4t9U/azm0qo4uhwPuNYWsmWpFxWfDex2MVB1Pa9CI92yCiTN7ylSrb4fsy22LOeXFkEYZKarq1UdJRh46NG9Kd82hBTC5yfU7UIPZcd/TRd7UnQ9Ifz+mRRJAq5G0fBvhZGb9UvJGNLdenjXCzs+ptOK56PjVp2pRAKSle/vMTdcAy/xsjx1N4AA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1726:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;20:EpVSCUvz/VFOpL6tkAgFnJ/FP7nwIuy2ycI+4i8xXNvpY+5VwfT7usJN83/NqXmAMjoQt02sLu0kTnEn8LeG+ty/jYFbCrDdI5oO7L9+/D7gVoy0Rwr3ZhrAJQ+y/uA2y1nQUGdOFPF61YDAiMKp1bqA8IOF8G7obuWiDRfepEqLnGNsra1HEljFEiyYVANFapWpOT3znVs85Bf2Jwe1NbF4Dzq8coLFsM3gBjr9xvxI6AB53QbgrgSMOYsqFbb5IDkWtJ/BLcMjRm8Q9VrQ/f7nZ2VsyT0JjvHqJjOD/Z6QZXPdQ9jmx11lDJ45rlJby+JN7MZmilJ4GaxXi+hdXZtd9hmUlYhZPtdXQBlfyvOiJhArmIgRdcAZr5aORyLvC8afN1ulVuCB360r4tbwNK1fvg8uC9jfyM2JiTocJp4a9Pjv5m2GFRXYQbd9To+zHnr6T2fYWbnHBqDXFBltubCOAy9TbsszbNCKyVSQJMXw4UwI5b6f0Q/2Cct0pUOD;4:MQcrk0lCsJkTZ5k+px2hNf05nf8jwaJWV/E64YSseMHEXeqRB5CimjOPOewukwqofh6rrqBggHtib0UaKKZu0+HA1rFQ+h2hiDbM53YSSluwBOyt9yyVDxamKOpQFCOWa8V0vtAgKDWJa652eMHCjXnXA05Od1vkwZlkRsdW7/wDUZfdHmePoyBYvO/zMhlBVhXupMjBHyK/i9O8Z4Gh0VeGmE9zm1kvgJ4kEY2ly+jhHDS+1WIe9i+Qmy9fHABI637aoyFLd0w+JRXBZqfBOXcbJp2ISVlz6ffF0z9cULUJoLxrrg0RHFMryCmo9Khe
X-Microsoft-Antispam-PRVS: <MWHPR12MB1726B66C84872F36ABE65F8483360@MWHPR12MB1726.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR12MB1726;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1726;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(52314003)(43544003)(189003)(199004)(6116002)(5660300001)(65956001)(81166006)(64126003)(6916009)(1706002)(6666003)(50466002)(86362001)(65826007)(8676002)(31686004)(7416002)(106356001)(93886005)(97736004)(305945005)(7736002)(105586002)(81156014)(53936002)(31696002)(6486002)(23676004)(6246003)(36756003)(16526019)(2486003)(52146003)(486006)(52116002)(316002)(4326008)(11346002)(76176011)(476003)(68736007)(54906003)(229853002)(8936002)(72206003)(46003)(14444005)(2906002)(446003)(58126008)(25786009)(47776003)(52396003)(67846002)(2870700001)(2616005)(386003)(478600001)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1726;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI2OzIzOkNDSlhjRXdrVU1oT0ZXV3I3ZXdMcFNSV2li?=
 =?utf-8?B?Q3ByNGRSZ1ZnbEl4YWc1MUVoa3N0bjYzTkY5aTh5TUVQN1YwdUVOTktZaE12?=
 =?utf-8?B?VlpYTVN3WVFjaFVkd01yaURBNUVuYVdPNVJRQXVTK2V5c1ppRS9BbVA2ei9a?=
 =?utf-8?B?Mlc2dUpPYStVb05BZ2NlV0NDMTV4dzJNRGZTRFhkWVpHb2FEMmc1YXFJS1cy?=
 =?utf-8?B?dGxOb2xxS3FsdWJUVTNRZDhyNjZyd3BnUkdyRWhLcVprWEpleG9TTzJjdVQ4?=
 =?utf-8?B?Y1gxckVCbEJ3c0N3WGY3SlRuQWlWbytDUTJaVHJxREFKTkM2UER0amFoTzlQ?=
 =?utf-8?B?Yi82dGFNUG0rV2lOaWY0ZVFrREZjelh5RHNIeW9PMiszS09mQndFZCtpRGpo?=
 =?utf-8?B?M2NMekp0OE1LTnM1Q0FUdEUvMm1tWFkrQWZzWkwzZDgzRGplbHI5Tk9zMWow?=
 =?utf-8?B?c1ZZbkw3cVB2NlFkaGlCcC81OHMxZUJRVmFhMjlSUXdyTXRQTHIwWjBOQ2xw?=
 =?utf-8?B?Ykpud0ptNTU4elBrMkJKTGtCblQ5SkdiZW83UVZqbEZ5WGlQRW1jcWZzQjlJ?=
 =?utf-8?B?dnpzNnFJYW5tbXd4WHB3ME1xcTJIK3VNeGlpcHFOV010QkhtdytQU0xCL2VG?=
 =?utf-8?B?cllOQjQ3TnFCMW9DZVpzdnpsK1g1K3Qza1JCY2ZnWDNMS1NlYzYwdEpVVTg1?=
 =?utf-8?B?SWQ0R0tjR1U4TUg0YjNPTWVXYnBhTDd6aGFsbjhqeHZaWFRlZWdiVDM3RGFq?=
 =?utf-8?B?d2Z5NkdUbk9iTlEwa05Vd0tNMmVlVWhHVXo0bjdTaCtOK1BzNGxTNUNsRlp6?=
 =?utf-8?B?aXNaQWRXQmplVEt4TWdGcUdwV245OElTdHJhbmV4aUZJcFFYODZxYTF6Ujhy?=
 =?utf-8?B?OSsydFFEWDFjMDQ5UEhsZFBRb20wZnR3SnI2bDA5SHV3UUlxSGZXSjUrU0l4?=
 =?utf-8?B?NU5tbXNTSHZGVnc0MEZkckhDOWJQMWo3QlJERWVyKzNrWFpBcC9IU3pHZWdX?=
 =?utf-8?B?em5QWWRGR3I3MnJoWWgwaHl2RG5BZE40SlA1NDEydGtQSk04K3V5cFhuMDhq?=
 =?utf-8?B?NTU4cjA2cDRTZE9BZDBpU2NsY2syV1cyODdVY0NDSy9VQjNiWldEVDFmODVk?=
 =?utf-8?B?Z0JzUzRZUnhSeXB6bHE2TmQ3dVJNaFZaMm9GRFM3d2dYUlYzRXdCdzM1U0w3?=
 =?utf-8?B?bjlVZFN0U0NtdmJUVVpkM3h2Vml0QkNqWTZ0SVNndTZ5QWpLRFBHYWx6VmZR?=
 =?utf-8?B?Y2dVRXZyTGlKUVhjaFVCcm9WMHJVZ0xSeFdtVE44aFBham85cyt5WGZ3bmti?=
 =?utf-8?B?REljWlEwMDNFSHcwTUhnaXo4a3V4cVB2YmQ5Y2lGSTBUbUlHY3ViNG5FZnhq?=
 =?utf-8?B?SkQxeTEzS3BsbmJFdFU2ek9pcURCbitVVWdvN2lIQVE0MlQ4OG5VK2dMTUdt?=
 =?utf-8?B?cVIvVHdYbjR2MldHVm9DL083bS84eHVOaDlickJKaUF5MFo3ZXF1ZFp0Sk1h?=
 =?utf-8?B?cUhtaU1jdzE3TldiQVhkNEtwbTlYVTdvc3ZtR2ptVHdWMGNRZURjeUE4Wmh4?=
 =?utf-8?B?Vzl1dkN2VnhkMjh4WjQzNk9nR05ibDBwNWJROGcwN0hvcWNqMGhTVk1Fd0Nl?=
 =?utf-8?B?aHRvUXhhTkFEMGp1NWVtZC9yWVR2NitmSElFRkd4VmQ5eXBFMzVkenJKSXk4?=
 =?utf-8?B?b2M5ZkV0Q25VWFNFVy8xdE5iWklMcUhSVG5KRDZTbjEyeFZlUk5sK1dBcXRJ?=
 =?utf-8?B?VGRnUGl1Uko3dmhVWndub0ZnTEZQZWNzeFVJVHVrTkpOSFVWV3FrZFhkbjNK?=
 =?utf-8?B?UlRBODhESGgzaEhMTmRzbE1yUVNsclcyeW1jdm55c25qM2pVdUN4c0hHR284?=
 =?utf-8?B?VFUrV3p6d01iWEFCRWlzcGZWZ0FnWEl6d1duRXJZUk5obkl1a2lscm9nZzhl?=
 =?utf-8?B?OVJsNUI1dyt6WFdqUHRUUnE1ak1CRUhRYkZ4UU9mYVR0Mld0cStpTm03VUli?=
 =?utf-8?Q?MLeLlN?=
X-Microsoft-Antispam-Message-Info: rg5tO6HJNXvjtZxIEhAZu/XLh9VCyGSpe51VRtqTEgwbmuZttWaRox8yxrhcz/epnX7d8MUUUGHS2W3Gm4yMB/tdVyJMKgTuDrbtOsCxCfsqUuTtaOW2+lfRQEj7zQwyP7IX0dhfLY02119saslwOwA+iQz6NFJksMUVZAV2MT0fcF95w9yrZgDB3W0d/DCpFmd9PUbfBMNNpe/Rw5G7qweBr1unQA2nMfnGW4DYW3wgTwsFUuW/MSi33yuzmtUvWqYSCRWQ45NNqKI7WFXhilbDfDqe4Wm7WuPMeXcu3B5e3Md+fkWPZuUHXeXSsNXrvdATRQu3q7QPOTYIccBZm2L8OSJazg5ua6mWpH5KYsE=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;6:QEXdPCIuBZ0XByW/WtG9CKAiO/QnW/bxrS4hbUbBGEvdjQOjJa3X7tCtBti9o3K1QUTmFjpUA4D+ZUTxjxy6f3FgjNCYD3sWt7+ENOZYFaOCG66KZGuRI4RdgZhFX/VD6UlMzZ0evcL+7u0FzlcCvLopd+fzYNjxBxIdpLq8fPmgmSqQpIM9rOTCG2cYPJxMT02l4+Y/WrShHlf1IbpFWAgMfXuI6Gbu0D7UDUBlASoyEK5RuwRGOklCJ6l+Wsqh6hnuZDBH3APp1X28ApXNDMCyht/t2waIBWNInFbv9bhTpeZ+Wi2zwqil3pBhRmUy5ZbLgENQvDzZq+g7wecO0CAXXt6OmGWWmh/0NNbZ2QgFSXfjMvVlBMckbNaHwrPY+IgjWT1IP0QcTgfAk4Wwl3QBMF0wYS8buW1OOeUsKhH9C5Yu/LVb8QxLtCQJU9TsDUkxG/OIhZp/aLVHswlYow==;5:3Gxw4lbnhsadFI1PzfJ8o7WMyGF6TLfIUHorlFYucSuicA7wME11gj+g3GuNoYlsBTDoMqTOjnZ+RmsoCYjwM87VZz5c28aPpOqDAz1CVT2OjzU1WhDisdM/REVFjsq4QhCPlNDqrqgUsvzJPSC7kM5jWKKtNLyvX5AxH9iun8E=;7:nGyrQbWf4VTcNZs+AvZPqnEcWesMzyBHlVRoPlS8CLyGZU5+V7G3XpYOsps7Tl1GRvh0UFRqIzojyvFlO3PVTtZXcufUGcB9xHOh0x5zQEG7mHFAvnHevfgjj2HwcSSplgQtsBJaTCsCv6zaZ52SeB1JbI2RBx+nhQKUXtTMXAo1hTva9pehgecCOPCLQ5ADvp1XNlm3zZP4TyuzvZ0VXXLsYn5pzMq8Q+7X/50IG+HPDIACEc+JJmK55YK0dc3h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;20:x8sS8eMVIcCiMpNp5wyn2IiiuQerr0RZBbasivd/BGSjw4wKYuVXbtJ8oKH0IXlSh4+XaowKmlNnPFoihGHhHYtoGUBZ8Fbb4OHbSn6LXTozZ96a25zlTQ+2y3F9nLWmXcxZf1Om0vaIOSlBR99DEBfw3J05R0FfnOBWFlTf3bcLaX4lrbdMIUKW1/0gk+bcGGnW54eUB5YY8qVxwNV8UEIVBejkKzd01lGFOoMvB/9Ua3TYERDathaWU1Wf+FvL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 13:44:17.8453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79243db5-5a51-4a6e-c1d6-08d609c7b4fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.2018 um 15:40 schrieb Michal Hocko:
> On Fri 24-08-18 15:28:33, Christian König wrote:
>> Am 24.08.2018 um 15:24 schrieb Michal Hocko:
>>> On Fri 24-08-18 15:10:08, Christian König wrote:
>>>> Am 24.08.2018 um 15:01 schrieb Michal Hocko:
>>>>> On Fri 24-08-18 14:52:26, Christian König wrote:
>>>>>> Am 24.08.2018 um 14:33 schrieb Michal Hocko:
>>>>> [...]
>>>>>>> Thiking about it some more, I can imagine that a notifier callback which
>>>>>>> performs an allocation might trigger a memory reclaim and that in turn
>>>>>>> might trigger a notifier to be invoked and recurse. But notifier
>>>>>>> shouldn't really allocate memory. They are called from deep MM code
>>>>>>> paths and this would be extremely deadlock prone. Maybe Jerome can come
>>>>>>> up some more realistic scenario. If not then I would propose to simplify
>>>>>>> the locking here. We have lockdep to catch self deadlocks and it is
>>>>>>> always better to handle a specific issue rather than having a code
>>>>>>> without a clear indication how it can recurse.
>>>>>> Well I agree that we should probably fix that, but I have some concerns to
>>>>>> remove the existing workaround.
>>>>>>
>>>>>> See we added that to get rid of a real problem in a customer environment and
>>>>>> I don't want to that to show up again.
>>>>> It would really help to know more about that case and fix it properly
>>>>> rather than workaround it like this. Anyway, let me think how to handle
>>>>> the non-blocking notifier invocation then. I was not able to come up
>>>>> with anything remotely sane yet.
>>>> With avoiding allocating memory in the write lock path I don't see an issue
>>>> any more with that.
>>>>
>>>> All what the write lock path does now is adding items to a linked lists,
>>>> arrays etc....
>>> Can we change it to non-sleepable lock then?
>> No, the write side doesn't sleep any more, but the read side does.
>>
>> See amdgpu_mn_invalidate_node() and that is where you actually need to
>> handle the non-blocking flag correctly.
> Ohh, right you are. We already handle that by bailing out before calling
> amdgpu_mn_invalidate_node in !blockable mode.

Yeah, that is sufficient.

It could be improved because we have something like 90% chance that 
amdgpu_mn_invalidate_node() actually doesn't need to do anything.

But I can take care of that when the patch set has landed.

> So does this looks good to
> you?

Yeah, that looks perfect to me. Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index e55508b39496..48fa152231be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -180,11 +180,15 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>    */
>   static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>   {
> -	if (blockable)
> -		mutex_lock(&amn->read_lock);
> -	else if (!mutex_trylock(&amn->read_lock))
> -		return -EAGAIN;
> -
> +	/*
> +	 * We can take sleepable lock even on !blockable mode because
> +	 * read_lock is only ever take from this path and the notifier
> +	 * lock never really sleeps. In fact the only reason why the
> +	 * later is sleepable is because the notifier itself might sleep
> +	 * in amdgpu_mn_invalidate_node but blockable mode is handled
> +	 * before calling into that path.
> +	 */
> +	mutex_lock(&amn->read_lock);
>   	if (atomic_inc_return(&amn->recursion) == 1)
>   		down_read_non_owner(&amn->lock);
>   	mutex_unlock(&amn->read_lock);

