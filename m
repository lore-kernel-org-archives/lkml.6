Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeEDWBc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 18:01:32 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:46061
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751687AbeEDWB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 18:01:28 -0400
X-YMail-OSG: meHPM8cVM1nMCP78r9IKLHC2.LMp0VY0YRfVAOVfGuAZ4Uo5MbGRkbgBtGvLcpZ
 NgMTGa53uzqEX8qw4OblJBbhdqjSdPwDY84GyeY0tUTwzv5AUeUEQAHUwQmjhnDX3tj7vJYG.Lpt
 VgGfDguzKOTfQcPXpJ1TdawOUr00fYXv2gGNOrtXl6vuBCJYBTzbm4B5NotYX19CbKRivij5_sOs
 jF6CKunFJmNJ_efsZJcQhB5LgIalRJk7Ztv7ZRXNLr6_M6l3ObOneavG00pK3bgNr4ZZz3cJM3HV
 flFbjPZq3XyAuwk8NtIExV6pIvnJqgEbfBrBINAaTaAIAqyqcmbHtYC964TvK8Qu8eUXvbxBoY.j
 YK76it6yoIiwll8GYPFKA.7twJDS.j8Y06rL_kBiCgH3Tm3vNAoORqgDqqYNPQW47ELfzNnVMu3h
 i.dBCfZtLUWnL6_lagpPfxW1.uDJ7L.Ub4TB8Dog9KBWGHAdhHlbCdZTrocG61N62pBtlmYIeTKU
 hArMbHxt4YH8OErm.u4cfrZnUaPEeNPz4mtsJBn5.IC1Z69W2PUVkrS1zjmYenem2WXGxJx_iB.S
 oMM7cTnN1yH.M3hkvjvNdqOckjVFeuFhTemPMsZNmVEcI.pmnRdMB.AD_nB_GMCMSC1DkXD7s9wY
 V8n4HoK8wvZJ1Dg4bN9lUKriAeEIF3xA6
Subject: Re: [PATCH v2 4/4] smack: provide socketpair callback
To: David Herrmann <dh.herrmann@gmail.com>, linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
        davem@davemloft.net, netdev@vger.kernel.org
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
 <20180504142822.15233-5-dh.herrmann@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <af4cf2cc-1335-557d-8790-633ff10371de@schaufler-ca.com>
Date: Fri, 4 May 2018 15:01:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504142822.15233-5-dh.herrmann@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/2018 7:28 AM, David Herrmann wrote:
> From: Tom Gundersen <teg@jklm.no>
>
> Make sure to implement the new socketpair callback so the SO_PEERSEC
> call on socketpair(2)s will return correct information.
>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

This doesn't look like it will cause any problems.
I've only been able to test it in a general way. I
haven't created specific tests, but it passes the
usual Smack use cases.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/smack/smack_lsm.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0b414836bebd..dcb976f98df2 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2842,6 +2842,27 @@ static int smack_socket_post_create(struct socket *sock, int family,
>  	return smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
>  }
>  
> +/**
> + * smack_socket_socketpair - create socket pair
> + * @socka: one socket
> + * @sockb: another socket
> + *
> + * Cross reference the peer labels for SO_PEERSEC
> + *
> + * Returns 0 on success, and error code otherwise
> + */
> +static int smack_socket_socketpair(struct socket *socka,
> +		                   struct socket *sockb)
> +{
> +	struct socket_smack *asp = socka->sk->sk_security;
> +	struct socket_smack *bsp = sockb->sk->sk_security;
> +
> +	asp->smk_packet = bsp->smk_out;
> +	bsp->smk_packet = asp->smk_out;
> +
> +	return 0;
> +}
> +
>  #ifdef SMACK_IPV6_PORT_LABELING
>  /**
>   * smack_socket_bind - record port binding information.
> @@ -4724,6 +4745,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(unix_may_send, smack_unix_may_send),
>  
>  	LSM_HOOK_INIT(socket_post_create, smack_socket_post_create),
> +	LSM_HOOK_INIT(socket_socketpair, smack_socket_socketpair),
>  #ifdef SMACK_IPV6_PORT_LABELING
>  	LSM_HOOK_INIT(socket_bind, smack_socket_bind),
>  #endif
