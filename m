Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeECGP1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 02:15:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:53441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeECGPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 02:15:23 -0400
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [V9fs-developer] [PATCH v2 1/2] net/9p: detecting invalid options
 as much as possible
From: "cgxu519@gmx.com" <cgxu519@gmx.com>
In-Reply-To: <20180502153258.39b65209a0a85063441c6d85@linux-foundation.org>
Date: Thu, 3 May 2018 14:14:55 +0800
Cc: "cgxu519@gmx.com" <cgxu519@gmx.com>, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <71B73328-C3E3-4472-986F-644A19209F65@gmx.com>
References: <1523947502-6103-1-git-send-email-cgxu519@gmx.com>
 <20180502153258.39b65209a0a85063441c6d85@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.6.18)
X-Provags-ID: V03:K1:5MkK+O7QUzyMeP2xvEzeb+xyK5O6jKu232LV+PJhypY8KC9Ykch
 adMWBJGyokRwrgeuH77qTjOPez4uDEedOSfm39MHDBH1QQDRzNKgjkNI7aF6x9gjLsCKAog
 zqEKZ2ji+XLHh8Y7UcS4C4g/nfXdhD+DWwl9pbvARBPHW7Dh6hSEW78kRitLniKONEctACP
 LaoLZUuO8FbdLxyb+ALAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t9OH/jBzkWc=:fR4ZmYnCeKszhBiHfXiA3p
 h3ZXE40/aS2l6MK4FM8GZv8VcN+dtELyLX6odRv7bM0Pb/tzQfFalvLKDvtI6DClqUbXRPyiW
 bZCs1Cciz/+YXvQ8GZ1KJ4n90OZ7g5/gCEkSPPqMXosxLqpMhOFpV64Dv0LypLbXAXUEwhi4e
 /qjS4QElp6FmiWXTG7HWMxnJkweNGRSenNs7+AJyvWBwpsjOcdDFSxOy8jHnIwMm2MUV9tj3O
 LiClIXfrqfdMvqdQEM1J4yJ0GzrNAzkb22iFX6O4+MSqqMRgJB82iTcQBVcODu4mbnlm6DvDh
 CxvP3Z6EKrOTs3O0DkWJzH53vvzECZRkX6oe7uH3rx0RfsUj/Zc7q63JEiRo0FcPRRXxnAO9m
 DDVw92jEH7YnMLaxFr1F+spokE+0K2DxIoOslCWP/N9CBjplLv48JIjnIgf1UZJHPr3PabBCb
 yiRvtCqIi2hf1tykrOFi170PVskAS5XWEL5ERZ8OdJp3yeOwcqq2/EiMakmoECft4MaVeNQdR
 ZpHUcHSMCZyQAN4f4DczFLtZFhc7Tftih0SLdwCLh/lH37CPgjc/5BYCP3BP6ranxKWxNNg8X
 LpSxOVB/pr/YKeP5oYS91HtmhIiW/NXwRgBt/ef29/f5+xOv63bqh8aRs8/ip0wV6Kjkj4abX
 9D+MQ3bDoq0FcrmyJiCPv+edwawkXtPV1OuxLhTZ7765E2VEd/ziHG0DhhNG+HIWcdhxvGtxf
 SfxNL7dmAH8iJH59vdgkI1H7JOPGlGcm9VtOKG+GYfUe0jUjKpDL0v8HEl7PhIWbEZrK0pCFA
 ahSWLHF
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review, I’ll fix the issue in v3.


> 在 2018年5月3日，上午6:32，Andrew Morton <akpm@linux-foundation.org> 写道：
> 
> On Tue, 17 Apr 2018 14:45:01 +0800 Chengguang Xu <cgxu519@gmx.com> wrote:
> 
>> Currently when detecting invalid options in option parsing,
>> some options(e.g. msize) just set errno and allow to continuously
>> validate other options so that it can detect invalid options
>> as much as possible and give proper error messages together.
>> 
>> This patch applies same rule to option 'trans' and 'version'
>> when detecting EINVAL.
>> 
>> ...
> 
> A few issues:
> 
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -199,7 +199,7 @@ static int parse_opts(char *opts, struct p9_client *clnt)
>> 					s);
>> 				ret = -EINVAL;
>> 				kfree(s);
>> -				goto free_and_return;
>> +				continue;
>> 			}
>> 			kfree(s);
>> 			break;
> 
> Here we can just do
> 
> --- a/net/9p/client.c~net-9p-detecting-invalid-options-as-much-as-possible-fix
> +++ a/net/9p/client.c
> @@ -198,8 +198,6 @@ static int parse_opts(char *opts, struct
> 				pr_info("Could not find request transport: %s\n",
> 					s);
> 				ret = -EINVAL;
> -				kfree(s);
> -				continue;
> 			}
> 			kfree(s);
> 			break;
> 
>> @@ -217,7 +217,7 @@ static int parse_opts(char *opts, struct p9_client *clnt)
>> 			ret = get_protocol_version(s);
> 
> And here's the patch introduces a bug: if `ret' has value -EINVAL from
> an earlier parsing error, this code will overwrite that error code with
> zero.
> 
> So you'll need to introduce a new temporary variable here.  And I
> suggest that for future-safety, we permit all error returns from
> get_protocol_version(), not just -EINVAL.  So something like:
> 
> --- a/net/9p/client.c~net-9p-detecting-invalid-options-as-much-as-possible-fix
> +++ a/net/9p/client.c
> @@ -214,13 +214,12 @@ static int parse_opts(char *opts, struct
> 					 "problem allocating copy of version arg\n");
> 				goto free_and_return;
> 			}
> -			ret = get_protocol_version(s);
> -			if (ret == -EINVAL) {
> -				kfree(s);
> -				continue;
> -			}
> +			pv = get_protocol_version(s);
> +			if (pv >= 0)
> +				clnt->proto_version = pv;
> +			else
> +				ret = pv;
> 			kfree(s);
> -			clnt->proto_version = ret;
> 			break;
> 		default:
> 			continue;
> _
> 
> 
> Similar changes can be made to patch 2/2.
> 
