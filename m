Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1042FC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBC420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5oi22ncb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBC420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeILFMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:12:55 -0400
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:10976
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbeILFMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JvERlGZyfVEraSnHJO6Q/cBc8th6TBf5Nq3hO6lUvY=;
 b=5oi22ncbEjeQNsme68AGuY8ARi264isNAhdv7hj8fZie+ksFHkn1beLmUIAJ0cyT7X+yNmfGuuvlhYMBuqQB32QNvobyfPnh+8suXfCL0uyAGVUmV7/uFQt7T3+DLEHlkJg/XuW1miv2hrfF82N5RA75e0L1NPABl48Qr9u0krQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 DM6PR12MB2681.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Wed, 12 Sep 2018 00:11:09 +0000
Cc:     brijesh.singh@amd.com, linux-crypto@vger.kernel.org,
        thomas.lendacky@amd.com, Gary Hook <Gary.Hook@amd.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH crypto-2.6] crypto: ccp: add timeout support in the SEV
 command
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1534367485-4386-1-git-send-email-brijesh.singh@amd.com>
 <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
 <20180904051930.5kvyyu75ym5mubuz@gondor.apana.org.au>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ec8245a3-1620-4501-0ebd-f04dfe973bc8@amd.com>
Date:   Tue, 11 Sep 2018 19:11:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904051930.5kvyyu75ym5mubuz@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN4PR0201CA0022.namprd02.prod.outlook.com
 (2603:10b6:803:2b::32) To DM6PR12MB2681.namprd12.prod.outlook.com
 (2603:10b6:5:4a::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1751b1-ee22-4c92-a579-08d618443df2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2681;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;3:AfXzmKvEcHDQIh6jjLsh4PX8tPvLk31/7FghJryJucyC2csSPG3x5L2JhtB1pCCs5gQeLlvUI9lVdeBbggXYUSBJ3NgEnb9jJAIKpyGL3vPKDaWIAymUtB1YB+ABbgftu+uDQE00u5KxIdun9243PJnmlOGgyyeAZEsF3iQqZeUbRhWBPRUsG7uUIoP4H2G9O7W9Sh19C8HomTtkY3dJ6g0r+oN9zRNvKSZwHkmCTheyHORW4geE4wp8LxS+YfxN;25:m1Mioakr9oOevT2qnEVZPrQIXDNHlYJ8dPb0q3XFNJCSBrVJMCUxpG7KAomP7y3OwA6gbINIiEtec71DdbXrlc6HwwAY7T9B96kILZaeABts4TzFPHTJeqCyg+n+nc1PHr2WfP/74Ol2NLL4uUGg3ntHLA0zHFQHjiVhZY3O25Xvd58jevclosHfKby4QUiAAXpxcNkKPhki1yTZZrK7e+Fh1BGI84eLS9O1Lk5AR0vyS2FpsqaU4djlfDZ0bZ2OMmHNAWO2+WDvMv61oGrgs1teZLzH07GwclHSRhbWaSgpO3Hg5QERbn5EbE/F2MRP2Rqlm4rGrMMwDSY/HUAg1w==;31:Psbg5cFZegeYwssD90icp5TdZuumXC8z1ojNNzY+z0xnjrTOJrUrAixIN8KgJ+WLAhab5HazMp99bUB0l5f4ucPo+0L6SludRDqcyOA1VWdw1eBwhABlqefavhvDwSYBMaGRNEsj5mY0Q0lWWp5cLzNjPEwkfPXhED7bfTLFicgi6IeZGBI9HWWg2T7q8ca/GDdlOhUqLCttOGB7XELH460cvMvL/Edaj36kghqUit8=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2681:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;20:Y3rsaWpK8HoxvTCnMRBv/Y7PkwxzuBXhnY54Hz9jEOKPtywQFjxsWt7zAKtAFSWdaE0wOKdo5ddTirkpXXc76yjMQBhD7tJQ7QO+pWdpMpRjocvmbyyUktmX+1NEx+4n/uqzODryQ3vdvOvCTDLaT0JNU+eHyfhHDQBiVs+qDUEseA7iWFr3i4KSMk8nvpN0yy0p/YgWu7qrO/NVr1ZzikYn0wHdq10uIh1sEzvomHOItBDc38tshb+zpV1w+vc/BPEb/SLGvKADQEtPpzoAnvJczrhVlJjWeO/L6g68G85DfmlAdAQ7Mtpqxgcd5HsOVptwc6NPTApbs4q5htYff06BUqtOIEJS5goYYwguJGQZEhwo/USkU+jRJwBgFyKcwGr/TW30IxWupJoz8B0Pd4o3nFaz7dIVajlFGdsyJ/Z7ar2NYlD8mgAwEdm72ha1ijRXhF2UfOLjKnlnviqgeY1UDL0jYQG1I4wTgtrTxFTOFzeRKd58fjucNrurNb/5;4:TbwfKqRIbIC0ZDVMJM9Q46GMpYDOlAuYmf0mRhfiVUJfXnMhVtQRIxbenC1v9CsOhMCiD4NBKFrr+eduedfIyPaxL0pQNOHorxMeTRd6VV/NS0zxSYISn09c967lGDKKtlOQ9xngUq7eWqQ2mVz8rVfrMh0+RQkAQeVRSuNUmTkft0Wn7i9mm7Ndk/AnYEoQ09SXF1PTdpm8UGjmAvuZ1h0OkkXVRemFyj5CMaMufIm8xTWk/demEbiCg+4VlOotljYFEVgqzTOObchAqSrWHELdAGJTi33KQt/v9X9OV1gWfiAr206RMyfjIXG2SeSsHSsMW8VzVwH2DLRGxeaD7A==
X-Microsoft-Antispam-PRVS: <DM6PR12MB2681E5209E4C1BD7F8D76B23E51B0@DM6PR12MB2681.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:DM6PR12MB2681;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2681;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(65826007)(54906003)(97736004)(31686004)(58126008)(16526019)(44832011)(47776003)(65956001)(230700001)(26005)(65806001)(2906002)(66066001)(50466002)(5660300001)(31696002)(6666003)(14444005)(316002)(2616005)(53546011)(6916009)(476003)(64126003)(446003)(11346002)(186003)(86362001)(386003)(956004)(4326008)(81156014)(81166006)(53936002)(36756003)(106356001)(76176011)(52146003)(6512007)(25786009)(486006)(478600001)(52116002)(6506007)(8676002)(229853002)(6246003)(8936002)(23676004)(68736007)(6486002)(3846002)(2486003)(105586002)(305945005)(7736002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2681;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgxOzIzOnpoYkhsMDRGOG4zYk9nTG10RkNXQXZWT2Vu?=
 =?utf-8?B?OWY4VU5iSlhPOVJNTmdESWRNN0hGY2MxS3FiaWVsK3VzSXppdE9iclJJenNL?=
 =?utf-8?B?WmF1cWw5QTEzbmFQc2xGOVlGSER6QjlENmlWZmpPdGs0UXpYTWppK0FUWGJP?=
 =?utf-8?B?QnJjV29MRVp5d0tlcGg0REMzQU4wYS9COW9sQjNRcWdMK3I1c0RpMUtCTi83?=
 =?utf-8?B?UWZyYlc0eEVpWlR4VU9uZ2FENjlHZ3BXd2ozY1JJVElrUFZiYS9yL2hOaDd2?=
 =?utf-8?B?cjMwWllNZm04UEJCbHdMQTVRdUVNN1Q0eWhXTXhnVi9oWHU5ak50Z2w3S3ZI?=
 =?utf-8?B?eW1laENGMHFxZ092ZitrbU83eXRvWFBRYkQ4c3UxOEZDbnZNNlFPa1R5eXEw?=
 =?utf-8?B?d0pjMU4wQ1RQbFJpUXh1V1dEMzdxNDEySVppenhBQ0FZNS9HTHNRTWROeVZG?=
 =?utf-8?B?clhZV1RSeHR2aGNjUE5uOGIrTUJlSDFDUHF0TnU0SUZoWDJzWVkwaWlLQWFo?=
 =?utf-8?B?V3o3Y3dQY0p1eU9ZK2htN0RNdlhrVi92QkZyaGhxc3FRVHNkdXpGWDB2Mk8z?=
 =?utf-8?B?V2hsamwwcWpSWk1LV2cxYWNuRWVRQXphVlFESVJtN3d1Vm9YZ0J0eHFtSzh0?=
 =?utf-8?B?dUxtbjg0MFNjcFNwZy9Cak9oTFZ6anVnclpiT3N6R0Q5TzloNHJCQjNrZ2VL?=
 =?utf-8?B?RnZEelFoSjYrT2F4ZUwxTEJUL0thS25vblZnRk14ZVJIOUVBNDByUWxIa0VN?=
 =?utf-8?B?RnBVUlFuSTVuSkorSlpDTmUrQWtrUW1BL1JaSlE5ak5ZZExiSkFNTFJxZkJT?=
 =?utf-8?B?ckVENTN5b29HZGpacUxST1dkUW1GNDdxWTFKcXZYRzlJSU5YM2orQStYRVFw?=
 =?utf-8?B?UnB1Q2NvTnpDdldOQXFsT05Xa0tST0NIU0ZRN0N1VFFxZHdkYjVaU29meVda?=
 =?utf-8?B?cXVOY2FPbk9PL28xcStSbmlRSEt4SjRkZlkyMFpqVFNiWVBqREl4YjQ1eXh5?=
 =?utf-8?B?LytTdUdnVmdXQXR1SFNmUVRLMVZ6Q2h1ZnBKMEdGZ3FVYmJPYUdOVFBTWlZm?=
 =?utf-8?B?WFQyYkFiWFpyVEUwOEhDQUMxbFB1Nk5UMGR1MmdMbGRJMmpyTVhSSGVMOWdT?=
 =?utf-8?B?dGIvcnR6NDd5UVFYUmNPQUQrOE01Um9CZ2VrbkNSL2t1SVNDeTVzT2s0SVln?=
 =?utf-8?B?cWkzMUtXZXZycW83dllDUS9FdGl5TzVVNThoSFFMTDE0Wk5saEtuYjFZUWM1?=
 =?utf-8?B?ZWFyZDlqNk9TWHpIWC9WR0hjUm5UcEo2bGd3K0FMYkpXU2tpNXhNK3ZEWHow?=
 =?utf-8?B?d3ZsbUVXWUk5cjl6R21HWk9QT3NJYnljaEt4NWFZUlVGZzYzNFpteUdpQytK?=
 =?utf-8?B?MGI0NFlsakpxNHpRY2o4ZEk4MWJZaEF2b2JESGw0cFZTbG4vTElkZ2poeDFa?=
 =?utf-8?B?bWRDQ1FJSGh0My9USU1mazB5bmRKbWUyUCtFNnR1emp1WE5Ea0wrKzFKczRC?=
 =?utf-8?B?V0xKRVFhZEN1Q3dyTm1PdEhpOENNSlZhRno5ck9CZ2J6MXAvaEZ5U2dTWXEy?=
 =?utf-8?B?ZVZCWEcwWmV6YnIrTjJzbmNvaDJ1ekpJbG1zK21CblI2SVR3Y0JoK01mUC9T?=
 =?utf-8?B?dStmbEc1VTAzVTN5aGxTdXdwWndQcmtnT05MQ0xKcWoxWk1MU1B5NzZ6QlpI?=
 =?utf-8?B?OGdHV25UMS9wSVhIL05aM1lOeDFhY3BzWC9MRkNrVzA3eFRtSXlJaDM5cHFL?=
 =?utf-8?B?cjRMRm1Fb1dqdEJscG9NY1JWeWt5dmZxcEdjSUcxOEJOT25EclN0c0pvUkY5?=
 =?utf-8?B?UjlMZGc2OWM4VG01d0JZWDhQVkNocEE2dW1lclpUQTRHRExPbHpJMFplTFZr?=
 =?utf-8?B?bXp1N2E5eS9GQ3dmUXpLTUVoUnBSOWUwcElOYkVRaFJpeVhBeTRNVHlIYkZH?=
 =?utf-8?Q?7taYItu8Q1aQ39mS4t46LaLPAL+b18=3D?=
X-Microsoft-Antispam-Message-Info: 2Xh80E3LaPD/2Jk/FsIcnNopA+w2x3jiMmuZT3Cal8E+jACDzlxAfpLlSgCff/XTFeOP0ENA75mlaFCmZ9gatvapck2faIGgdszSa9/L0ptI6c+H2Y3ia5JjNvCHsW9iYAq3hH9tWNxAObQt8ODrKwcTyxupekh0NDa8uUHLB846TCt0fTEf3a9B94GmH3NQqsDv1ZKOn6MQfGGCbITZ1mN84LaJ9aYMryXEsaqWMIvvFJW7vsKhZ5Aw3oQDazkid0vsYYPUITRR5HQ6jH+M+bx+llJ17NtSLFQOhoXbAwSV/FtvvRilkomJ5Hfs/oW5uCwjJRvriV5k9765zVYnBboBAEeWM/9Z5J6dsYwxqFA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;6:o8Q0XhAg3CM3vKsSzfKyee3nGOaoBMwSxFrXIVXZ5uw7ZhJabJ6S+/IDtymbsdyGR/ujbnsjx2puiESQCkWiIj5/s05NLEZWu8h4gcWnuP93p2oBcwYNVd0Z0+/v1SBMeMHX6Olk75pu5Tty9mnsztNV5vztEJrzpWiUif5OhWPS1EYMxR6sn1Ur56tYSiSsd8r29uggDsC+tHGp/+3NA6S0Y0yjB1XcqTp299VKNxqHkfm++k3q1kWSPs2lE3+uokgBwR2A9NtVI5sucKLe5lH7XLIhRu4jMwRs9LsEnTPLllPF4mjUjwmLA09S3nQzkjHC5RA0drvOMswuG3g2GmmxLxFrKldkZGxd9QGJYlXxIMq6MIImmf6UBopZkkGTotyMJp40O0LyjP7p0+ALSVzyOoeNijHRtxDond3CT7N7n+dqW7ERy0R+c9dy2VvshpjW2epQS9DNcvY13mgFLw==;5:9g0/IfvOznvYL+pwJBnbZ4oVy5NJrerjZs2REtoSIZqxRDxQ0NXTgypB+ripbiEfOYm7ffg8D05jSiv1Bf9TCSUi0sVhaTcfAA343MJ1EfpmACj9nc1w2UwUzpVCkYUcuhZwJxT6VQ+KQBnmxIu612Or+i0njxsZBpoUFGt5kD4=;7:I9RReYUaoZGUgXrUzBTKptwlBpvh+9Z3ClP4gzJfhFrdYHz/jVUlg5AI6kymLyKhSwkhQKao4EJTJmhMVe/BszmvAxxUZqXz/VL7lNlRRRRXqpfKg9EScPmnURvoIrS8Qd01YZY2oigLIxOoWdFDDsHqrdvgzOfH8H5U2l30e1LfrXZMhXozzgj4ay1CtSH6jRHe+myuNXORjFSr9p+mybcqAmamO3+cJxj8d84QqjcRw8uw5GRLr4kygso0pcug
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;20:WeN3YZc4YGN/3V2NRjgpgd00ZsCd0ljWcZo8mtW3fADah9bd8T6oHqIGX1Wr5bllkAWpOuHNXzO9sXdxhSr9ghz5lVzv7j/1Ukf2vD7zp1WQXZQ+XVNmutwUcZ7gbsLLrR1/m1hL6EjxveBqOtE6EZKOsP5ilKBP7aFP891juP+T0KvIqE929N1ymRiYjx7c1rpIjmBmrLdT/nhnnoUNHzu7FTRdNwY63yU+ID8xoMaiVYnC7rFAvig06TDfiEV+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 00:11:09.0285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1751b1-ee22-4c92-a579-08d618443df2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/18 12:19 AM, Herbert Xu wrote:
> On Wed, Aug 15, 2018 at 04:11:25PM -0500, Brijesh Singh wrote:
>> Currently, the CCP driver assumes that the SEV command issued to the PSP
>> will always return (i.e. it will never hang).  But recently, firmware bugs
>> have shown that a command can hang.  Since of the SEV commands are used
>> in probe routines, this can cause boot hangs and/or loss of virtualization
>> capabilities.
>>
>> To protect against firmware bugs, add a timeout in the SEV command
>> execution flow.  If a command does not complete within the specified
>> timeout then return -ETIMEOUT and stop the driver from executing any
>> further commands since the state of the SEV firmware is unknown.
>>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Gary Hook <Gary.Hook@amd.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  drivers/crypto/ccp/psp-dev.c | 46 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 41 insertions(+), 5 deletions(-)
> Patch applied.  Thanks.
Thanks Herbert.

Can you please include this patch in your next 4.19-rcX pull request?
Multiple folks are encountering this firmware bug on Ryzen systems. I
will submit the modified version of this patch for stable release (s) so
that we fix issues in 4.18,.17 and .16. thank you.

-Brijesh

