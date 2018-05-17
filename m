Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526579624; cv=none;
        d=google.com; s=arc-20160816;
        b=meJtWCWdCEoZXaUXnDH4gZR3TQ9x3aGRL9ieUs+YgqZc/HsLcFVZA9uX4LPfXfpOHs
         lJUeSytlsi/lgi34a0duXBM9gwFP1gPbdOYBjSJOsAW1t4QaXZA3OA+Be7wjycllu3v0
         dDE4NYIpCfM+YIOlGGCkfifpskHMzONiW3137E/nQ0xOpSnmRk2DOSUW7DL3RbXlmCp/
         X9UsLyHb7M6jq8614lWT4BSnNFL7qGQOsSXUpaJcVBpGBTEcUddDQcs7EWmZNNzpn4GN
         Tn2ePfDme3vwpieelbhLZsBs0WD75Qg9r4Zxbfn4UA3EczbEl0VixGiXmd29LFVyMIVR
         8vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=88BdI++o4UeCvPRllsAENHt78bLtihYttq5svOwULEo=;
        b=bgDdAyWQsltMxXG+mwagLF07gP5ia3uCStNm6s0pg7dQAO63go/vIi2zMVi69pZ4qD
         0EU4+HqBd3+mvpwq5qSe2+xShuvf4ll2MNb2KO/zFnOjoFYcvuWtC95rvWiEiS4KwNrG
         X1au55VVXrdrS+ijm0q12lIiM2y+1JBUL1fJa/rKztOrYUii/usW0o1uCkWozTxJIg2W
         4j+flNCBekS4JL9bGGj4zJhvhVeeYRwhC58g48SAkzd/2GnZX6gaxFYb7ELJXqglOfmk
         ISHzzs6fdpJFKD9AufSHxnRMOXX4f2dPCaNcTN6xS0ceif7EyNRocGbBdaOfz+ROV9eh
         QBkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Vx7IGR5+;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Vx7IGR5+;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoGPXuLVN4If2QVX/VP9N8vm3CaCJcxxMi4BBOjXrE43mpiVB0rnCiE+54K/1IJRwXCfqAyUw==
Subject: Re: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org,
 gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
 <20180517065544.GO20254@sirena.org.uk>
 <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
 <20180517172308.GX20254@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7f308220-65c9-503a-50d7-d61a3f99c64f@linaro.org>
Date: Thu, 17 May 2018 18:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180517172308.GX20254@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991553144563990?=
X-GMAIL-MSGID: =?utf-8?q?1600734756091473237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 17/05/18 18:23, Mark Brown wrote:
> On Thu, May 17, 2018 at 06:10:49PM +0100, Srinivas Kandagatla wrote:
>> On 17/05/18 07:55, Mark Brown wrote:
>>> On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:
> 
>>> This lock only protects the list, it does nothing to ensure that the
>>> port we look up is still valid by the time we return to the caller.
>>> That means we won't crash during list traversal but does nothing to
>>> ensure we won't crash immediately afterwards if the port is deallocated
>>> just after we look it up.  What stops that happening?
> 
>> Each port is allocated and de-allocated in dai probe and remove calls
>> respectively.
> 
>> Lets say... So for this case to happen the dai has to be removed (unload
>> module) at the same time when the interrupt callback happens due to delayed
>> response from previous commands.
> 
>> This case would be almost impossible because all the calls to afe service
>> are synchronous with timeouts, if any of the previous calls times out the
>> respective caller would get an error, this should prevent him from unloading
>> the module in the first place.
> 
> The user can also trigger manual unbinds without unloading the module,
> and to be honet the scenario where the DSP has stopped responding well
> and is delaying responses sounds like exactly the sort of time when
> users might try to reload the driver...Yes, that is one possible usecase!
ref-counting port should stop that from happening.
I will add this in next spin!

thanks,
srini
