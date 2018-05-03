Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZqloXv2nM0O5r2bO7VtWqlebFazrXGxtTm1PpUXkIOgG1IKOvOuFrbRJuARM5aC2YqPBZvG
ARC-Seal: i=1; a=rsa-sha256; t=1525354754; cv=none;
        d=google.com; s=arc-20160816;
        b=Qo8+95rp1xDqm5U46g28A0ol5Xh3ULfhbZYng2wzNIrz6Y4eolhn2uOyeHRJVEoCbA
         c2dr1Z7g6Q2gz+nhe/XjQtd6gLHeRhHbWcZIkwpj/8r5yqGcCM2h1Ew1p6RgGq3pSdKK
         1ob1JVrbx3+fWG45AryznVFWwtPp+tC29SmRrRZryOdi8fUZu/njMP5X/Q9QF0st6NcH
         8fmdL+mlzZvzxmHkZdCwErfCWk/Yv3K8lDysZLpqB3W0f4B/AHDmxnrrQqnfmBYnGMwF
         QFmowvtG46TzYvqAq+i9PavUhj6pwoCy3c0xzq9+aB9TASnM10UlCfK0U0pLP2tquTPP
         a2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=VqweUXJOoFjghQp/iGhn6eAHdtZh5A8kFTBWtFGa5XA=;
        b=swMQWadWhNkziaFnzRHKNsd2V4q8GZsvmtp6TOD8eApfcAHXQoeRsHreHPmEB2WQyV
         Ympd6waukwcGXP+OaxaZWB7Dtod9nJyMMEGP7oydkVS4ZFsKEU2jrHJdnT212QoV7KFQ
         tCis+TfmgTEBjh4Nx/a3brL9SvMfSuekE4g6nLx6gEQKFpG8/MaJuTR7nsDL5Mrd0JSV
         IJcGIqiMZVl89G87BcSfdl28W/rLF3vUHRkalhd9mluqMsX/YynI0wTBdl3KRHtHvmki
         +bWwaHA69N+koZcCos0JYybkr+Z/xIrjL4dCVNFWoAIZ+392PXjlxPWA+Np04Xrh71l9
         pUvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=J7uOjU/B;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=J7uOjU/B;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-3-pasha.tatashin@oracle.com> <20180503055407.GN3791@eros>
In-Reply-To: <20180503055407.GN3791@eros>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 May 2018 13:38:35 +0000
X-Gmail-Original-Message-ID: <CAGM2reYu8uNuasJmsrJ8nzSJ5Zs2466D=ytgG21dJCd+7RO7fQ@mail.gmail.com>
Message-ID: <CAGM2reYu8uNuasJmsrJ8nzSJ5Zs2466D=ytgG21dJCd+7RO7fQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers core: multi-threading device shutdown
To: tobin@apporbit.com
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030121
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413926103775713?=
X-GMAIL-MSGID: =?utf-8?q?1599450386861925375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 1:54 AM Tobin C. Harding <tobin@apporbit.com> wrote:

> This code was a pleasure to read, super clean.


Hi Tobin,

Thank you very much for your review, I will address all of your comments in
the next revision.

BTW, I found  a lock ordering issue in my work that  that I will need to
fix:

In device_shutdown() device_lock() must be taken before
devices_kset->list_lock. Instead I will use device_trylock(), and if that
fails, will drop devices_kset->list_lock and acquiring the device lock
outside, and check that the device is still in the list after taking the
list lock again.

Pavel
