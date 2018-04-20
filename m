Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AIpwx49JKbui4DcIdo6LkvNwzw3OWWZAtjbXiOsEv1wHyDXFkBbe/wPwkrxO+jPJzBSaLRZAQS8l
ARC-Seal: i=1; a=rsa-sha256; t=1524227990; cv=none;
        d=google.com; s=arc-20160816;
        b=UXD+anU6lRwYeY7k6a6uwthZovYi54Am+q0Vys8Tv+Jj12KBv082HdmrdBPVgUQFLO
         vw5L4H9WSszCO7McBT2ingYjjNM8miYwz7BHumgifqw3Mtgcv17Yha1FjrSaW4du5gwm
         LLBz2tUBF6jy+YvNSfoFRmmRrxWvKzxyJz1CPNg9dQGfzoZomwMGJMt3zJqO7rdoahlz
         3SvRlip8qNtyQub8GIGgw2VxTM2cjWDn0ZijFFmMnVbFVCzdWCkfd+W1esa3xRg+uhWS
         0aS5wt7oe5bDsVIra/qWeHnyLPFn56O6ILnn/VIS+7IPTxO1KDH09WVpwH5GBH2KmjcA
         0I0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=JhNUrwBr8Rogit4+fe84DES3yDgjcOoeVBkESolM9WU=;
        b=oUqN5XgkKkD2AzWPys9SqHSe6bbBI8S3rTS25lbhGr8Ar2TGUNhesM6c2apKFY5tDG
         +9L26lMKsJcG22cFpwS7PxdLYvK95bYNctikUsWfn+TbOdUVNK76JwyMQbwNTKNrlyfn
         Hub4pCLt3sM6x62akteD17zPvDy949tCBq4n8YIIOCi5OYH0wRsDQ+Q0mdJ5lBI4jg6Q
         2Lwjpj121hxxSAFYA5l+M/7rUqV8UuN69cQFBzMI6UerirQPlYzLG24vV+X95/9Dvvzc
         waTBDYnCsJKMdhfWjNmu0wjhtdqhjC8t05FJgAqoYRQMNeMX6WGWNnHee55D4UOTSXeq
         Dozw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="35130742"
Message-ID: <1524227986.21176.467.camel@linux.intel.com>
Subject: Re: [RESEND][PATCH 2/4] NFC: st21nfca: Fix memory OOB and leak
 issues in connectivity events handler
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Amit Pundir <amit.pundir@linaro.org>, lkml
 <linux-kernel@vger.kernel.org>,  linux-wireless@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Christophe Ricard
 <christophe.ricard@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, John
 Stultz <john.stultz@linaro.org>, Dmitry Shmidt <dimitrysh@google.com>, Todd
 Kjos <tkjos@google.com>, Android Kernel Team <kernel-team@android.com>,
 Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Apr 2018 15:39:46 +0300
In-Reply-To: <1524045904-7005-3-git-send-email-amit.pundir@linaro.org>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
	 <1524045904-7005-3-git-send-email-amit.pundir@linaro.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077974606996222?=
X-GMAIL-MSGID: =?utf-8?q?1598268889925426702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-18 at 15:35 +0530, Amit Pundir wrote:

>  		if (skb->data[transaction->aid_len + 2] !=
> -		    NFC_EVT_TRANSACTION_PARAMS_TAG)
> +		    NFC_EVT_TRANSACTION_PARAMS_TAG ||
> +		    skb->len < transaction->aid_len + transaction-
> >params_len + 4) {

> +			devm_kfree(dev, transaction);

Oh, no.

This is not memory leak per se, this is bad choice of devm_ API where it
should use plain kmalloc() / kfree().

>  			return -EPROTO;
> +		}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
