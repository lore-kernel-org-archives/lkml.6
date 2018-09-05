Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD6520857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD6520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeIETN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:13:57 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37612 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:13:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id BF6D22180B;
        Wed,  5 Sep 2018 14:43:25 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UDRWH_BJ44gD; Wed,  5 Sep 2018 14:43:25 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 7E32920F43;
        Wed,  5 Sep 2018 14:43:15 +0000 (UTC)
Subject: Re: [PATCH 1/2] Fix cg_read_strcmp()
To:     jgkamat@fb.com
Cc:     linux-kselftest@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, jaygkamat@gmail.com,
        Shuah Khan <shuah@kernel.org>
References: <20180905010827.27743-1-jgkamat@fb.com>
 <20180905010827.27743-2-jgkamat@fb.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <50897170-ca93-47be-2f99-d9e9ba0dd111@kernel.org>
Date:   Wed, 5 Sep 2018 08:43:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905010827.27743-2-jgkamat@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jay,

Thanks for the patch. Couple of comments below.

On 09/04/2018 07:08 PM, jgkamat@fb.com wrote:
> From: Jay Kamat <jgkamat@fb.com>
> 
> Fix a couple issues with cg_read_strcmp(), to improve correctness of
> cgroup tests
> - Fix cg_read_strcmp() always returning 0 for empty "needle" strings
> - Fix a memory leak in cg_read_strcmp()
> 
> Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")
> 
> Signed-off-by: Jay Kamat <jgkamat@fb.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 1e9e3c470561..4aadf38bcd5d 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -91,15 +91,24 @@ int cg_read_strcmp(const char *cgroup, const char *control,
>  {
>  	size_t size = strlen(expected) + 1;
>  	char *buf;
> +	int ret;
> +
> +	/* Handle the case of comparing against empty string */
> +	if (size == 1)
> +		size = 32;

Why not test for !expected and avoid strlen(expected) all together?

>  
>  	buf = malloc(size);
>  	if (!buf)
>  		return -1;
>  
> -	if (cg_read(cgroup, control, buf, size))
> +	if (cg_read(cgroup, control, buf, size)) {
> +		free(buf);
>  		return -1;
> +	}
>  
> -	return strcmp(expected, buf);
> +	ret = strcmp(expected, buf);
> +	free(buf);
> +	return ret;
>  }
>  
>  int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
> 

thanks,
-- Shuah
