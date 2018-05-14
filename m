Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeENTHY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:07:24 -0400
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:60694
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751515AbeENTHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:07:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-7-git-send-email-vladbu@mellanox.com> <20180514164753.GF2134@nanopsycho.orion>
User-agent: mu4e 0.9.16; emacs 25.2.1
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 06/14] net: sched: implement reference counted action release
In-reply-to: <20180514164753.GF2134@nanopsycho.orion>
Date: Mon, 14 May 2018 22:07:06 +0300
Message-ID: <vbfsh6udpk5.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P195CA0082.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::35) To HE1PR05MB4698.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4698;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;3:BAKQwmauFaCMngB/rQ0mtEWivsaUIvXPwVrlhE4U5g9x7r9C2e+MnobN9JEy+fDkRTa8ITCLZ6Z/EyWpuxP6Z6I2m4q9YCNrM+LJAlclGVd4vgHTCLroGFQkTd43c6mHyDC9yEbmaIIq8ESOi9exUBwqiuGE7mJtryTWw1r6KgGE4+d8DpHMTWCbKeKR1MIOuCdYrLRt3lLGS3ZxttgddM6Ad1YoF9zn6o1iWPGcUHQ58FlzVfym5tPbcaFWYnAH;25:H1IM84oTrnbIKq1O4NcNZZKArUFzkhuE8F87pZ6J0DW+8Dpikl7vltT5DiZEXSDemJWqfRqmWN/xEDGIgd6rdll6ShDEFaA0eFidFxByto62vP5KHV3ABnvfyqpzRUH8yaP/Yex6UZOl1KTHszTZ0p9noUH70J+ZsWRukJ+Cxy5s+2IplPO7fPfcWmYaJV37+ghF7yRTTnl79hkNm+WS05xHJY8Sp8WYfcNP7MtJiM3eZVyiC/6L0weDkFE6uNnPfSLf9ly6Av12u2ZcOVj4TPs2Hlml7UP549l0EYtomcbgEXbtU90KhLQl8oOHWHKotHp8xnUKiwOKFN2Z66okNA==;31:YCRe3lZn7W57dWgABCjfVL9/NB4uDIi1xbCuEBDybLulZyIgarb3973oY5KHgfgVFemlbhF2hDb2tO+L2WM5baouMoIa0eVFHjyqyYE6qs6L5DpFn+tc6iUe70AKFc/jMGuWW4cURqGi9wzfeY14uwHsfX9gCz2f/JAtYa14NZ+hnJxzAmpNuiBdBavCqOK9OX5DHOE5gGEZNdZGzSvKas7sX/eD3T6JyZtRpWJwYfs=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4698:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;20:nT8alPrpQGa+xjL4ZABdivwRAv8hITEesqq2SNeIx3ynAYOLDozrVO7QwqiFjNsuAJB/mgD7Y7sGNYGIdawOhQzdk5zKFiess0cNC5AlpfBHCZJnHjOdS3rjVGX4k3i68FH5qtORhZLrxwJsXJxVo0AJVsxq7qHjuAzOru22TwxHWQMu/iztB9IMLXGsiupjHddajpCrdDYc3w8ibn5TXi+pz2UBIh4V3CSEm8FbA7n8GMmFa6XRhr1Wp/QFp+vLtALrT9hRNjLIeRAXPkzZRxp0csS7J+ZGzhSKqON1uhsIaRIWVwfDuWntO3MR2LGf2sZPt9IoJPP1qE8jX3vgxcAMkSZtUnCTZ3V8m1qtSTQ8Kyj1EcIWWPXgvaEWMS+Oh8yOWn0TmRCss8ZFxKSJTE7w/69gZA1zqKfm+UV8MyvH71s8LvKPDPMGaIB4h0n9i89Q/5Unocn50PfwFjAL9QDG5s1APj5NxFnyCXXcEiLQTFTlYebPUEzJKejEQfDT;4:R577TzAizE6TwltExNd/8srPTHa+sMoUhdnaBXaIVfD1dbY7OQva6aoz4pNLHNmtJBryb+y79NlpXja8ZGOZKFaep5yjdgiP5Ft/W3mxHMBUK5rdcm2NQ6Ku9aN/YvltgzN5cAfIbH/rAyT3Izr8p+ZdN9K4DHPTwqcfHY3y8B/6ZedGOuvX8bb0FHGQdYung10Ibwn/6URpen5NYWQfVvYINxWw894AZ8dVmImgwmAVPfnnIYGm7ALFiPo5EQwINTnq6uKB+FkO4Qc2bR2L1g==
X-Microsoft-Antispam-PRVS: <HE1PR05MB4698257810B9173F8273FCD7AD9C0@HE1PR05MB4698.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR05MB4698;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4698;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(189003)(199004)(6486002)(50466002)(68736007)(4326008)(7736002)(107886003)(2906002)(53936002)(39060400002)(6246003)(305945005)(6916009)(6666003)(8936002)(81166006)(86362001)(81156014)(105586002)(48376002)(6512007)(8676002)(9686003)(16526019)(106356001)(76176011)(16586007)(7416002)(7696005)(486006)(59450400001)(956004)(476003)(52116002)(316002)(51416003)(386003)(25786009)(58126008)(26005)(3846002)(6116002)(5660300001)(229853002)(97736004)(446003)(11346002)(66066001)(47776003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4698;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4698;23:vvxuvqLRQxyebR46Am3DN329RN8XT+LILxLMINTui?=
 =?us-ascii?Q?zNCB9vXW9qT6exkiaTB13P1PzmQmQlbiw9NScndGMUZzFlMq6PanENV6VLdO?=
 =?us-ascii?Q?+Usrt+XJBeAF+LmJl9Kce/7ra8e4nwjE6EgocRCdih52NVZbonV5g2+vA4tT?=
 =?us-ascii?Q?WAe53My8YT+g5m+FAXLUyvGLEgP4F0i9AQLPjmvgl6Szl5kMpbQSF416Qp+R?=
 =?us-ascii?Q?rhJtLNXkJjEpI9WCpFDKpf18qTCb9PpsOxVUkXohAzcoFdLDZDPrK2R4NLWO?=
 =?us-ascii?Q?drck8HOrtCj43RpxggHtBOR5xd9GGQ6QlxjfXVrRL8TmGJgieKmKE11f686g?=
 =?us-ascii?Q?5c2LulaOrr+eVAi8X0ANl4dr3vUYc7TgUeA7lNqK5QjMsFvhMV2WCzgdkkir?=
 =?us-ascii?Q?kq0WHGyjKYYH7LzpcWJIGjrOUypvTv1zkkWwjRQ+Ojid+LUbGEEQkkDgMjdr?=
 =?us-ascii?Q?RIiwBJayx5P0sd4+6g0L6sjvIMkOydTDcYzlrzorCC7o/iOOzTaimu8tHfHA?=
 =?us-ascii?Q?Ckk+xOQqo0VMxLD2v030ur8/MEbwV9jvnpFzAHSzZWHCIDCx8/CZDTmXAoN/?=
 =?us-ascii?Q?9NEn0BdVBSMGtSYEMkMv/QcNI+pig8uzJScatmQuVKgIJPLg26HnB7CElAjY?=
 =?us-ascii?Q?12OsdIFt7B0id0bAyDoGeqygSMfGJC4D7ehWr7tVLegDI8ZegsWhacj665l3?=
 =?us-ascii?Q?OqpUD6lE4ySD7AFz229pjDyGNTJp55vkhYEAL9A8eBCY6vbbHD9qcD6ytePI?=
 =?us-ascii?Q?DBqLSy9DFUVE4KaIRznV/DdWd9lGocQRmhmhNbHUDApA6W/0XtdCWAE5LIS0?=
 =?us-ascii?Q?k+fd4k6xJqyQxXeVsQKNK4xxTsh7nD7fM80AyPwe00JmTuPoS1nWoyQqcSfT?=
 =?us-ascii?Q?0rBEMPDMSAeQB+dhQgrN7winZL5f/JuJQOWTmtHwPf59WPS8EKkqvycXEGCj?=
 =?us-ascii?Q?D3oy255hw7HXUFnAfiO5EFFKArEnQH6B4ShkSKNjnOTA0KinAuVxPs3I4rbl?=
 =?us-ascii?Q?N+KCC8OCDZ87ehyFw9yEu7AV3TFbG3/zjSR7cKn3CA3jAYhTXPOXSSZ6I0G/?=
 =?us-ascii?Q?0gxsGq0zE8BOW6/1bdFOscrlDa5hBF3KopU8yhIlCNs7TDZ55kczIfWjMkhL?=
 =?us-ascii?Q?H8kMJfMT9M/6PnpOGsNLRe0Iu2FMN6IJb+WiJhP+/brlEk0/lbFqZ9/8AOO+?=
 =?us-ascii?Q?3ZtFygd3/AyJJqVwk7e7z1kcMswBFM/QIW3U3vnTxuFvjiUNkN50AAF9AADW?=
 =?us-ascii?Q?DcFVxZeRzvCaCYTzoBs7cWc0J+vgkoedT943hZk?=
X-Microsoft-Antispam-Message-Info: 158qJqncSug7tKGRrWj7OLrUvSPCIO/doXCutG7UnSPDvVy2J1G7NV9NKdzKKa74aZaKKKg42QUehpRsTQCzwTvaiTXDXPpvUY0sNbs0F+Ww9r5/Gv4G7gzxYPhuVsmY+fyQXaX7kecO49VGs15q38FVW9vpu6Z8W7fxKnLKLLuquRGTVTRKhpZAmGfyOLcL
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;6:NGx1OqoGt1CCN+I9IHTXDy6IAIdcrlOvm/TjmGjy/b+bma2OLz1JMQXtmODkPeQGH2xZOysOjMFRTnGcXJD7m2f4t98vJVAfpYd5h168UpmMgzo5FzrePnpkDmg7LPoh3v6z8RLKoupgJ6V1SNkSW1EmMx2ApouiYm8FzN/YTU4hVtst5PnsoBFLwJ2zt92vkWmvYZBG7kY6DjzI/bfDf3/Pmtdf1+JGxSCWv902llm2xGpvOaRLYHhTYDjHXMqxQuJL5pCtpMwyGlvFqsCI2HBCxmd1qhjkmOmcUq6+4W5S5LGOhwZZFMiUbEPhIKlb5wKnikrtsEfo6qDq5xcwvdZ/oG2G6B42n5WS6bOWqq4Vz5HAlMscyOBmy5x4By2EEthYovGvBcVlfloLbbpIB7AtTbs3eHaEslzma3Dte84IqrZa2VRyb+Pfjnenhzw1Qz602LrBdLGhRe+yVn8fqQ==;5:4PAj1GuhjYohqiQYsJQWbl/w4zuLOw8crGNtvqFfyqxDJJA3R34cu0Ad1WbkSqh0NncMMsgfx103iz5QLElLDV/YbJ/ycrXup08r3kGHk/9kLi3xxwUkc3t9+WVPJ2Qj86JVR0aIzFt6eL7s7CUmR8/6rzsTM2vOQp5ow4n+edU=;24:FvE2nvYTjWl20aeNERRN5KK9wQw+S+B793xlVisRuq8V3TkStulEYdV3YMCJJeFtxSEMU5fasjurJCqK4C3a7a4p+7uypbRjckathOBa19w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;7:qmMNxZ7TaMVPU7nO+tRnJu28jAsajgI2eBk41dDZ9TtMfqWXTobmvjm8oJj2mpwJop9Ij9zERQkFxbHiMRhw00zW56ZPbn2y72oleIgn9BdKrxG8XRgT/EoncbyNKd7Wmvsh33rN7UT0izM/2pRdoL0b1SWL3w/0ahjzmMFXZ2H96SBYGTKu9s97g0QBhV4akixz1QqYrN0ViZtRVxT2I69x6gFXwl0Iz6kWgm+5VQj6/HN3yaHcz4QtsVyZKfj3
X-MS-Office365-Filtering-Correlation-Id: af74e968-092d-452c-799a-08d5b9cde82d
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 19:07:12.7990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af74e968-092d-452c-799a-08d5b9cde82d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4698
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 14 May 2018 at 16:47, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:07PM CEST, vladbu@mellanox.com wrote:
>
> [...]
>
>
>>+static int tcf_action_del_1(struct net *net, char *kind, u32 index,
>>+			    struct netlink_ext_ack *extack)
>>+{
>>+	const struct tc_action_ops *ops;
>>+	int err = -EINVAL;
>>+
>>+	ops = tc_lookup_action_n(kind);
>>+	if (!ops) {
>
> How this can happen? Apparently you hold reference to the module since
> you put it couple lines below. In that case, I don't really understand
> why you need to lookup and just don't use "ops" pointer you have in
> tcf_action_delete().

The problem is that I cant really delete action while holding reference
to it. I can try to decrement reference twice, however that might result
race condition if another task tries to delete that action at the same
time.

Imagine situation:
1. Action is in actions idr, refcount==1
2. Task tries to delete action, takes reference while working with it,
refcount==2
3. Another task tries to delete same action, takes reference,
refcount==3
4. First task decrements refcount twice, refcount==1
5. At the same time second task decrements refcount twice, refcount==-1

My solution is to save action index, but release the reference. Then try
to lookup action again and delete it if it is still in idr. (was not
concurrently deleted)

Now same potential race condition with this patch:
1. Action is in actions idr, refcount==1
2. Task tries to delete action, takes reference while working with it,
refcount==2
3. Another task tries to delete same action, takes reference,
refcount==3
4. First task releases reference and deletes actions from idr, which
results another refcount decrement, refcount==1
5. At the same time second task releases reference to action,
refcount==0, action is deleted
6. When task tries to lookup-delete action from idr by index, action is
not found. This case is handled correctly by code and no negative
overflow of refcount happens.

>
>
>>+		NL_SET_ERR_MSG(extack, "Specified TC action not found");
>>+		goto err_out;
>>+	}
>>+
>>+	if (ops->delete)
>>+		err = ops->delete(net, index);
>>+
>>+	module_put(ops->owner);
>>+err_out:
>>+	return err;
>>+}
>>+
>> static int tca_action_flush(struct net *net, struct nlattr *nla,
>> 			    struct nlmsghdr *n, u32 portid,
>> 			    struct netlink_ext_ack *extack)
>>@@ -1052,6 +1088,36 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
>> 	return err;
>> }
>> 
>>+static int tcf_action_delete(struct net *net, struct list_head *actions,
>>+			     struct netlink_ext_ack *extack)
>>+{
>>+	int ret;
>>+	struct tc_action *a, *tmp;
>>+	char kind[IFNAMSIZ];
>>+	u32 act_index;
>>+
>>+	list_for_each_entry_safe(a, tmp, actions, list) {
>>+		const struct tc_action_ops *ops = a->ops;
>>+
>>+		/* Actions can be deleted concurrently
>>+		 * so we must save their type and id to search again
>>+		 * after reference is released.
>>+		 */
>>+		strncpy(kind, a->ops->kind, sizeof(kind) - 1);
>>+		act_index = a->tcfa_index;
>>+
>>+		list_del(&a->list);
>>+		if (tcf_action_put(a))
>>+			module_put(ops->owner);
>>+
>>+		/* now do the delete */
>>+		ret = tcf_action_del_1(net, kind, act_index, extack);
>>+		if (ret < 0)
>>+			return ret;
>>+	}
>>+	return 0;
>>+}
>>+
>
> [...]
