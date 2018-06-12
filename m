Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B7966C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFE120891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fQ5mp/05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFE120891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbeFLSkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:40:23 -0400
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:51328
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752696AbeFLSkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJdDykz18apcOTZHNji6W63cnpAuw3O7Mm7S0wTEoBc=;
 b=fQ5mp/05D2gXX8woF3oXkI0VI8trVgOp3DtNNylAJFs03BdPGhB++iYGUr+viKMR48T5FtVj1txd0bFT4CgmlQuRy3/YKMJA7ERSfcnSSdhLvTt6QslDJB3sjdSlSw/HSIiYhVzrRycXo7yqI7Bihy+NpAe7jf7dfuOQmnDHdLk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [10.236.109.62] (165.204.78.1) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.16; Tue, 12 Jun 2018 18:40:18 +0000
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To:     Randy Dunlap <rdunlap@infradead.org>, Greg KH <greg@kroah.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
 <20180529183917.GA10618@kroah.com>
 <9713a0b2-1450-7783-712f-ba27f8a09b2b@infradead.org>
From:   Gary R Hook <gary.hook@amd.com>
Message-ID: <da1b355b-d40f-222c-5daf-c91a6ca41eda@amd.com>
Date:   Tue, 12 Jun 2018 13:40:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9713a0b2-1450-7783-712f-ba27f8a09b2b@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0012.namprd05.prod.outlook.com
 (2603:10b6:803:40::25) To DM5PR12MB1451.namprd12.prod.outlook.com
 (2603:10b6:4:d::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1451;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;3:Bykx6LaQnJuOsxUF5yWMQBRDFkut8qwUb5Su6TBQYKcoLfLeFyuP+v2ekLaY2f17auKxavq+WF6NEbKkZp5f8bSjGSmp4Mrd2KZeFsSq9TiGnoKfTugiKzsdK8sIbg41p781jmJt4s1RiaZkDbSJGId6oCozbLfl2wEuQkTzVDgLqMAc82q/j+EtDKUEPFNVLRsc7Ed0ae1b3c9c56IlyPjWgPVwCq8IsBSq+8KlKeu92sL2XFFoL0JJ2kfJRJu1;25:l4YOjzASq1X33Lt9Y0QKh0dRueH13DONND/Kb75CJ6q4Alp/dqZOlOTO2l46AVxNRcvZnjS820X1CVYGuZVGgLdNBpXxunSzfK3N2ze4PTgBwGKhjxPcOQAU8VcrfTABaOA/+HM6ccgPeZUGlgZBsdtKDkV15JdMB3tN8qp57lnl+twQGJJCZ77vTihcmsTlfWbeB5TcDyId4qumNnk9q4f8YSf/B5nNr6f5uiMMSaw7yZKdm3Di2G7hcMQVgjQaeqim502hex3lACES0x2bQNEnXrkLnK/iKtPgLqyGzHtpdsFKdun2DwHJ6bS86KU1Gbp86sB9eXVpwz3lDwgi9Q==;31:fK8yxGC02umkC3x0qlRltKZmcIedY8+iAWPyxPLqd0ZD8BHG17BQzbkT2DG/1XqKDdGa+jQRrtmBg7WogMUfyB9nBFC+DrVmDOHj/qKWajfbeyt+fo44pEwJOjDmF33OXpPACmHncqUbI6I4Go0LhVQeLTJIMu54c+xGlTcVlaY1pB9cCqDTdoDoV3xI/FGHWQMu6S2QoGQ1kzzaMCRn8/0p0O4FO0gugbgSe1YntAw=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;20:sYekP0t/sZ8FzjnoZbHmJ7CZpNbCdAvvCsUC1yqohjrfg9AGxGd7/FRC9GhLgPGTns5smpSGHLKobZzrAWoUWthwXB/l4i9xGAuLTd8f6EtQO4EEAqgcM6r11RMmJaPyssJbPlX7rLLRFb7iepLScYJSSSzCcf0L5DKTA3blEb27am1eDsa1NL9QWXWUBE1CeFsQcmZb4ov6HDSZJJvBKGx8kvTdRMOntguHA3PCyF1xEhjKHiY3XkovqJCShao9BZWDynVhv9eU1dsZ6aSdH8FX1uf4JAAam3duUzLF232CduMrN6XN5/60YzKsL3riYC0PNavXbR1uKcN1N9Dmm2qyljcq8Eg/2YxQLNU2zDNA1yuE/jMPem6TJI/kkVNlJDiRAz2ZoK/11MP0YemdY5H80rBjsCWl7IvxmEYu5cBT3F2fX8BvTAShnGEHDBdPqZ2+hwaeqIgCaZVzByU9SoE8MQ/m++SioSZN7ArrXVBmlbd6JSV2kroRf1bKUHnb;4:bLvamzogW3L8D/JnlGVmsfyzqSY4dx5s2M0A+tNUPhnTXkHEKBPHVXwe9rnFNigbHhnBY0Q+STCdLgU/DFMTW/lcUs59WfCDakqM/Cxubkl9j2PY3ZEDPKwD+KQ0DOR5kjZ2HkcqVwTUhnB58mEo3WsbAyrF8IQ5NHKycDX8aWrxGftwiZhp3OROFTums//XYp2etW5+8OMAEX+rkT7ntDZIu2UjWk6RNhDvEU+UWlTZR0tJM8TD4w4AwDZ/HIPSOycxdL0n2E0Qk2cKkLqo8qhnWaV16xYs7JV7yHYqD2meyId1LPf/9VV8vN6PfWnI
X-Microsoft-Antispam-PRVS: <DM5PR12MB14510B3D3BFC5C34A7B93600FD7F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1451;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1451;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(72206003)(446003)(68736007)(81156014)(64126003)(81166006)(11346002)(478600001)(77096007)(26005)(50466002)(110136005)(58126008)(67846002)(486006)(52116002)(2486003)(6486002)(52146003)(8936002)(23676004)(53936002)(16526019)(8676002)(36756003)(25786009)(2616005)(956004)(476003)(230700001)(31686004)(6246003)(53546011)(4326008)(386003)(186003)(229853002)(97736004)(76176011)(16576012)(105586002)(93886005)(106356001)(316002)(86362001)(47776003)(65956001)(65806001)(66066001)(31696002)(6116002)(65826007)(3846002)(5660300001)(6666003)(2906002)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1451;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUxOzIzOmpUWkFKWjJseXc4WEZ0VUE2cThKazYzdFli?=
 =?utf-8?B?NTZsYWJuMjI2dWgvY0F1YmYya3dnd2NhT01MWllmQXI3QnhhdTlPcE5CMUZZ?=
 =?utf-8?B?NXcrUUpOZmJQOGZFOTBYQmVvaE5NYXRTMDJWT3J2V0pMby96N3J6bGxzZnV4?=
 =?utf-8?B?anFHSkxsc0tMczN2TThEUjhkdi9aY0tQQTh5YVhVMVVYWU5Fb0RXTW5Vd2tB?=
 =?utf-8?B?R1lmNTZXV1NuUm5pU213NnFZcXlIVWRjOU5TNG5PM2htZjhGakdRd20zRGZ3?=
 =?utf-8?B?ZFlOZyt2OTBRN0lKd0NXVnhqSXVwVzloOXBHbEpvSTU3ZW5nSmpKUWUwc1JY?=
 =?utf-8?B?L3hhTmNzZS9ESWx4OUcrTnJRbmRQMk1UODYzMEI2ZjBGSlVDdnIvcUt0YVhO?=
 =?utf-8?B?bGZ1RzlObjZCdCt3YU9qU0VrY2ZzejcyS0M0R1hSdHgvak9qaSt6R3dscTI5?=
 =?utf-8?B?UEV4RkZQbVdCR3FvZXJmUVNnaVBCN2oveHVmakN1QTQ4VWs2ZStDdkk5eEZN?=
 =?utf-8?B?STl5SVZHbGdiY0dQV0V6WGkwRHJuY242eStGOGVwY29BS2xOQlZXaW1uUXBR?=
 =?utf-8?B?S0hJZS9GZ29UaWQyL3hybTVDZlFhZDJ5VUhpS201ZXBoZUJMN25lWTllUlpu?=
 =?utf-8?B?WHREeURaQVNFUlgvekFGcXZTaTltdmJEeWVKR1dRMi9YNUp2Ukd2Ui9iZjJM?=
 =?utf-8?B?T0dlQng2RjZ4ampwUWFVczR6a3dNVjBHbUYrN2xTanFrMkFVM2xkYlBQTG9s?=
 =?utf-8?B?azYyK0NlZkI5cURHd09DZ3MyWkdiUTB4VHRGTkN4WjZ6YTdQbzZlQVZxekxX?=
 =?utf-8?B?blhjNjdQT1R6c2FBeUpaTXhhR1R6WlFrUGxLNGlMa0V5K3pKd2NENEFrU3VW?=
 =?utf-8?B?NU1iK0tsZ3l5TFFwYWtWOGU1OGt0M0ZySEZrNzJOM3docTByTnNFNkpnM1hT?=
 =?utf-8?B?VEhjWC9RazFDSWFITDRGU0thS1VSbWZ3aHE3MjUzWVZtT3MrK2xpZ3ZZTnpJ?=
 =?utf-8?B?blJBNzlscDB5UitlNUJ1MzdSMnlJME5JZmxBQjFJbFBtc01jV2ZuVVA5dFZQ?=
 =?utf-8?B?VFBONGRibDhEWmtOUFF5VXp2M3NaZWVRcWtnUHByZE9Qb2pTZ1lqdVRNK2xH?=
 =?utf-8?B?dThLQWZaa0hERjFSRFpJMkNEL1YrMlVYTFlEZWc2M3k4OWlGUzhZTVplOTZF?=
 =?utf-8?B?cmVaSGg1VGU1RXU1bEppV3VXZ25BK1puNGRqaXRMQkZ2Ly9EMmJ3UTQ1VmJ5?=
 =?utf-8?B?UVREWS9YSHNvRm1vOVpKT2Z1aWVka05sTUhsRG0vbTVjU1VuQ3prazc0aHRs?=
 =?utf-8?B?T3FDRVl5VUNuVjVudTBmQnNQaDFaQXJFU3dweHJHRjY1bkJ1QTlDN2lQY0ZD?=
 =?utf-8?B?TFJjd1h3NXV6dXZQYmVNYUxOcUx1VVNiaVJXY3kybFNYQnZ2MjMySU5RZGZP?=
 =?utf-8?B?ajdwVHREMllXOWJyTlFTSW9iYzBkWUJzVlpMcWpmU1c2OU5LeFdQb2R6MHFJ?=
 =?utf-8?B?MkNSM3R0aGNOSDlacU9WVWVoWXZUSEwrNStYa1MvSzk3YWZ5V0dFeDU4dlk3?=
 =?utf-8?B?SHdLVVk0QjZVdE5lM3RnVzM0aHBNZGhGcFpUaDlPK1BtWFNWaFdydHpDSEgx?=
 =?utf-8?B?L085OVBBZnVwa1U1bThuY21qQ3BhdG5DQzRRNnZBOVpua21va0JlL2VuM2Fu?=
 =?utf-8?B?dTRNK3F2OWVKWDhSNFN0T3dFMUxVSmlaNXVId1ZuVkhRVldQRjRpei90cTN0?=
 =?utf-8?B?ZU9CQXk4K2YvNjB1d0FxcWxvejBzdzlIZHI0Y3VETVVQTkYvNE1LQyttNXlS?=
 =?utf-8?B?VGs2bVgzeU1mR2Z1SnBQd1pEN293bGc4Z3A5OWNOWmhhL21SMyt5d0RJczA1?=
 =?utf-8?B?NVRXVWpaNUdqK3ZyMEprTHc4eGxBQW9FSDNMY2NrSm9keHUyT2pqWHgvS1RF?=
 =?utf-8?B?blg2WmcwL2JlYUxTQi8wMnF4WnE1ZUIyK3lqR0ZRRFdNN3R6NFU5aXdoenBY?=
 =?utf-8?B?L0I3NG9ESnBPK050VGtlZnpDRmNBTVo1V3dmdz09?=
X-Microsoft-Antispam-Message-Info: 5EJx/H/S0lissRUifOR9BTzlxn3Ck0giuJL1F82EkfHdiGH6lGQyxAxN5Zmlu0Fz2iMzK/laC5OcHuycNwa0+KEE9k0k9/zP4uBUTExj0MYSf1bIngA0ZK4GA2GTydwgy09MqpMuh1ub6MBCScsI7/du/KXh7TQingSELfWqpeIP5aFbJv5ibOXbf7fdVZ1W
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;6:4vzeLZVPYDE9EDxtzOZbOBsUKevlywFklHZy+foqh9qd/7hdZEG59aBcTpgcOtBpL46GCpmIJBdUBdB9gA+S4f1Wm9jJ447y0XrpAnm+DlQT+YmD3JTc8+X2EpOvLlC0v+8WxzklaiKmqJ2ajl0lae7+wW0xTHQcnKeUk+DN1AdubBJtnCMLDKtbF+wDvl4kwdo7c1X3v+mKTCNQ0pFsm245z2V6FN3MqQ1wdlk+LOAGFgzOAfG1VSIxEkZmkbCXSG4/RQzSaDWOnBswfN+pp9f2DGMAqtacCLoot2+e/hExI4ivBDx+Kd06KMVfwqbeTb1E9Yu0N+iHDZizjvkSX5C5C+vP0IDn348wPjpTq8NK+vjsp4cX6vqT80HVebP6TrE/uXIP8UfAv/jdss9PLoYOEHSFP8mi9KXS9mb+gMmrv2Wx4l4BtqwC3CU7XHRKIhAS33QBZchq9IQl/DEo5g==;5:we2fyWvRYl2lHdSWEh/ntUXqA8IiCGQDvbOqcY5YR9rBoBww/tCugG55A26PHxOAp23hd1jpuGkuh6QpTF6DFkFx2pvAApyZZlR2y7pkImemN1fd6Jo4eEI91sqG31gN5CwSANe4oMKczigSlh9cpdFhg9CUyZkm+UXg7K/RPL4=;24:HfA58VmIfBC0xM5uRR82SymPOF7hgYw9Ti8688+fg8fFm1tX+yaG7xs5f6pG+d1Xcyou9EAdLlSCF3+sh3BaYYaYpv2qAbk06HKMPj01fSg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;7:KSzNC+YJ4TCHWNGskXGBG04Rg3YvUUSL2JgTfMdauBFA7BVS0UxG//N0XHlDjMrCkJUNra3EJMbIyKmUiemy2o0FR0hOpnWXMurmllHgZj+B6qr74LAqlGtqb1jIbIHf8kzDrccXFSP/08jw1RxS1qMi71Lmdn9wnCZpjm2tjd3EBScVasWy2aibydQRKH63oiazys/hTRvySUKT2TicgtMBjd4ddqsTQP8vhzLmmXgPq+g/dEsSKrtHHhmqP4AS;20:+Sk070mk7BHz1CKy8JGrGJZ336hiPJOmwA442Ye94PVlDYJJx2D3jWMivyskVinvDSldZSxS9sQ31/GnN6t+dl2F7i+HsDJUe/yD+B4LFK7iMdv5Y3q+xp9Ayd7bCnfHi3Q7RHwddvmKnk/AVnvLujHjKDqt2AdUaQpZ5I61Xm1+JuNa+F4gafhw51hboCA1ocHvMpHMYiptecLdZPYq8QKzFW5erA45NUAdjVjonRoXc6Hp3nPoL38VWZhqcarw
X-MS-Office365-Filtering-Correlation-Id: 109ca7d0-da0c-4f58-55d8-08d5d093f232
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 18:40:18.1575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 109ca7d0-da0c-4f58-55d8-08d5d093f232
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 08:23 PM, Randy Dunlap wrote:
> On 05/29/2018 11:39 AM, Greg KH wrote:
>> On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
>>> Implement a skeleton framework for debugfs support in the
>>> AMD IOMMU. Add a hidden boolean to Kconfig that is defined
>>> for the AMD IOMMU when general IOMMY DebugFS support is
>>> enabled.
>>>
>>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>>> ---
>>>   drivers/iommu/Kconfig             |    4 ++++
>>>   drivers/iommu/Makefile            |    1 +
>>>   drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>>   drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>>   drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>>   drivers/iommu/amd_iommu_types.h   |    5 +++++
>>>   6 files changed, 59 insertions(+), 2 deletions(-)
>>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>>
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index f9af25ac409f..ec223f6f4ad4 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -137,6 +137,10 @@ config AMD_IOMMU
>>>   	  your BIOS for an option to enable it or if you have an IVRS ACPI
>>>   	  table.
>>>   
>>> +config AMD_IOMMU_DEBUGFS
>>> +	def_bool y
>>
>> Why default y?  Can you not boot a box without this?  If not, it should
>> not be Y.
>>
>>> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
>>> +
>>>   config AMD_IOMMU_V2
>>>   	tristate "AMD IOMMU Version 2 driver"
>>>   	depends on AMD_IOMMU
> 
> Gary,
> 
> By far, most driver-debugfs additions are optional and include a user Kconfig prompt
> so that user's can choose whether to enable it or not.
> 
> I suggest that the way forward is to fix Greg's debugfs_() api comments
> and to add a prompt string to AMD_IOMMU_DEBUGFS.

Roger. I think we have that all worked out. Will send another version soon.

Thanks.
